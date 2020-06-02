//
// Created by mason on 3/8/20.
//

#include "verilog_new_syntax_check.h"

/*!
@brief searches across an entire verilog source tree, verify the new defined syntax
*/
void verilog_single_module_check(ast_module_declaration *module) {
    ast_list *signals_db = ast_list_new();

    for (int m = 0; m < module->net_declarations->items; m++) {
        ast_net_declaration *net_declaration = ast_list_get(module->net_declarations, m);

        ast_module_signal *tr = ast_net_declaration_to_module_signal(net_declaration);
        ast_list_append(signals_db, tr);

    }

    for (int m = 0; m < module->reg_declarations->items; m++) {
        ast_reg_declaration *reg_declaration = ast_list_get(module->reg_declarations, m);

        ast_module_signal *tr = ast_reg_declaration_to_module_signal(reg_declaration);
        ast_list_append(signals_db, tr);

    }

    for (int m = 0; m < module->module_ports->items; m++) {
        ast_port_reference *port_reference = ast_list_get(module->module_ports, m);

        if (module->is_new_style) {
            ast_module_signal *tr = ast_port_reference_to_module_signal(port_reference);
            tr->index = m;
            ast_list_append(signals_db, tr);
        } else {
            ast_boolean found = AST_FALSE;
            for (int i = 0; i < signals_db->items; i++) {
                ast_module_signal *signal = ast_list_get(signals_db, i);
                if (strcmp(signal->signal_name->identifier, port_reference->port_name->identifier) == 0) {
                    signal->direction = port_reference->direction;
                    signal->signal_info_comment = port_reference->port_info_comment;
                    signal->index = m;
                    found = AST_TRUE;
                    break;
                }
            }
            if (found == AST_FALSE) {
                ast_module_signal *tr = ast_port_reference_to_module_signal(port_reference);
                tr->index = m;
                ast_list_append(signals_db, tr);
            }
        }
    }

    for (int i = 0; i < signals_db->items; i++) {
        ast_module_signal *signal = ast_list_get(signals_db, i);
        signal->module_name = module->identifier;
        if(signal->value != NULL){
            ast_list* primarys = ast_list_new();

            ast_find_primary_from_expression(signal->value, signals_db, primarys);
            for(int j = 0; j < primarys->items; j++){
                ast_signal_dependency* primary = ast_list_get(primarys, j);
                ast_boolean found = AST_FALSE;

                for(int k = 0; k < signal->dependency->items; k++){
                    ast_signal_dependency* old_dep = ast_list_get(signal->dependency, k);
                    if(strcmp(old_dep->signal->signal_name->identifier, primary->signal->signal_name->identifier) == 0){
                        found = AST_TRUE;
                    }
                }
                if(found == AST_FALSE){
                    ast_list_append(signal->dependency, primary);
                }
            }

        }

    }

    int statement_idx = 0;
    
    for (int m = 0; m < module->always_blocks->items; m++) {
        ast_statement_block *always_block = ast_list_get(module->always_blocks, m);
        assert(always_block->type == BLOCK_SEQUENTIAL_ALWAYS);

        ast_timing_control_statement *trigger = always_block->trigger;
        if(trigger == NULL){
            ast_list* sensitives_list = ast_list_new();
            statement_idx += 1;
            analysis_signal_dependency(statement_idx, ast_list_get(always_block->statements, 0), signals_db, sensitives_list);
        } else {
            switch (trigger->type){
                case TIMING_CTRL_EVENT_CONTROL: {
                    switch (trigger->event_ctrl->type) {
                        case EVENT_CTRL_TRIGGERS: {
                            ast_event_expression *always_block_sensitives = trigger->event_ctrl->expression;
                            ast_list *sensitives_list = ast_list_new();
                            ast_find_trigger_list(always_block_sensitives, signals_db, sensitives_list);
                            statement_idx += 1;
                            analysis_signal_dependency(statement_idx, trigger->statement, signals_db, sensitives_list);
                            break;
                        }
                        case EVENT_CTRL_ANY: {
                            ast_list *sensitives_list = ast_list_new();
//                    ast_find_trigger_list(always_block_sensitives, signals_db, sensitives_list);
                            statement_idx += 1;
                            analysis_signal_dependency(statement_idx, trigger->statement, signals_db, sensitives_list);

                            break;
                        }
                        default: {
                            // similar to continuous assignment
                            printf("unimplemented ctrl type %d\n", trigger->event_ctrl->type);
                            assert(0);
                            break;
                        }
                    }
                    break;
                }
                default: {
                    assert(0);
                }
            }
        }
    }
    for(int m = 0; m < module->continuous_assignments->items; m++){
        ast_continuous_assignment* assignment = ast_list_get(module->continuous_assignments, m);
        for(int mm = 0; mm < assignment->assignments->items; mm++){
            ast_single_assignment* single_assignment = ast_list_get(assignment->assignments, mm);

            ast_statement* state = ast_calloc(1, sizeof(ast_statement));
            state->type = STM_ASSIGNMENT;
            state->assignment = ast_calloc(1, sizeof(ast_assignment));
            state->assignment->procedural = ast_calloc(1, sizeof(ast_procedural_assignment));
            state->assignment->procedural->expression = single_assignment->expression;
            state->assignment->procedural->lval = single_assignment->lval;
            state->assignment->type = ASSIGNMENT_NONBLOCKING;

            ast_list* emptylist = ast_list_new();
            statement_idx += 1;
            analysis_signal_dependency(statement_idx, state, signals_db, emptylist);

        }

    }

    print_signal_list(module, signals_db);
    module->signals_db = signals_db;
}

ast_signal_dependency* ast_signal_dependency_from_string(ast_identifier identifier, ast_signal_dependency_type type, ast_list* signals_db){
    for(int i = 0; i < signals_db->items; i++){
        ast_module_signal* signal = ast_list_get(signals_db, i);

        if(strcmp(identifier->identifier, signal->signal_name->identifier) == 0) {
            ast_signal_dependency* signal_dependency = ast_calloc(1, sizeof(ast_signal_dependency));
            signal_dependency->type = type;//
            signal_dependency->signal = signal;
            return signal_dependency;
        }
    }
    return NULL;
}


void ast_find_trigger_list(ast_event_expression* exp, ast_list* signals_db, ast_list* event_list){
    if(exp->type == EVENT_SEQUENCE) {
        ast_event_expression* left_exp = ast_list_get(exp->sequence, 0);
        ast_event_expression* right_exp = ast_list_get(exp->sequence, 1);
        ast_find_trigger_list(left_exp, signals_db, event_list);
        ast_find_trigger_list(right_exp, signals_db, event_list);
    } else {
        assert(exp->expression->type == PRIMARY_EXPRESSION);
        ast_signal_dependency_type type = exp->type == EVENT_EXPRESSION? SIGNAL_DEPENDENCY_ANY:
        (exp->type == EVENT_NEGEDGE? SIGNAL_DEPENDENCY_NEGEDGE: SIGNAL_DEPENDENCY_POSEDGE);
        ast_signal_dependency* dependency = ast_signal_dependency_from_string(exp->expression->primary->value.identifier,
                type,  signals_db);
        assert(dependency != NULL);
        ast_list_append(event_list, dependency);
    }
}

void ast_find_primary_from_expression(ast_expression* exp, ast_list* signals_db, ast_list* result){
    switch (exp->type){
        case UNARY_EXPRESSION:
        case PRIMARY_EXPRESSION:{
            switch (exp->primary->value_type){
                case PRIMARY_IDENTIFIER:{
                    ast_signal_dependency* dependency = ast_signal_dependency_from_string(exp->primary->value.identifier,
                                                                                          SIGNAL_DEPENDENCY_CONCURRENT,  signals_db);
                    if(dependency != NULL)
                        ast_list_append(result, dependency);
                    break;
                }
                case PRIMARY_NUMBER: {
                    // just do nothing;
                    break;
                }
                case PRIMARY_CONCATENATION:{
                    if(exp->primary->value.concatenation->repeat != NULL)
                        ast_find_primary_from_expression(exp->primary->value.concatenation->repeat, signals_db, result);

                    for(int i = 0; i < exp->primary->value.concatenation->items->items; i++){
                        ast_expression* exp2 = ast_list_get(exp->primary->value.concatenation->items, i);
                        ast_find_primary_from_expression(exp2, signals_db, result);
                    }
                    break;
                }
                case PRIMARY_MINMAX_EXP: {
                    ast_find_primary_from_expression(exp->primary->value.minmax, signals_db, result);
                    break;
                }

                case PRIMARY_FUNCTION_CALL: {
                    for(int i = 0 ; i < exp->primary->value.function_call->arguments->items; i++){
                        ast_expression* exp_n = ast_list_get(exp->primary->value.function_call->arguments, i);
                        ast_find_primary_from_expression(exp_n, signals_db, result);
                    }

                    break;
                }
                default: {
                    printf("%s\n", ast_expression_tostring(exp));
                    assert(0);
                    break;
                }
            }
            break;
        }
        case BINARY_EXPRESSION: {
            ast_find_primary_from_expression(exp->left, signals_db, result);
            ast_find_primary_from_expression(exp->right, signals_db, result);
            break;
        }
        case MINTYPMAX_EXPRESSION:{
            assert(exp->left == NULL && exp->right == NULL);
            ast_find_primary_from_expression(exp->aux, signals_db, result);
            break;
        }

        case CONDITIONAL_EXPRESSION:{
            ast_find_primary_from_expression(exp->left, signals_db, result);
            ast_find_primary_from_expression(exp->right, signals_db, result);
            ast_find_primary_from_expression(exp->aux, signals_db, result);
            break;
        }



        default: {
            printf("tostring %s\n", ast_expression_tostring(exp));
            assert(0);
        }
    }
}

void verilog_net_module_check(ast_module_declaration *module,  ast_pipeline_tree* current_node) {
    //verilog_single_module_check(module);

    for(int i = 0; i < module->module_instantiations->items; i++){
        ast_module_instantiation* instantiation = ast_list_get(module->module_instantiations, i);
        if(instantiation->resolved == AST_FALSE) {
            printf("INFO> can't solve module %s\n", instantiation->module_identifer->identifier);
            continue;
        }

        if(instantiation->declaration->module_comment == NULL) {
            continue;
        } else {
            char* cur_name = current_node->module_name->identifier;
            char* inst_name = instantiation->declaration->module_comment->identifier;
            ast_boolean prefix_same = AST_TRUE;
            for(int j = 0; j < strlen(cur_name); j++){
                if(cur_name[j] != inst_name[j])
                    prefix_same = AST_FALSE;
            }
            if(prefix_same == AST_TRUE){
                instantiation->module_ptr = module;

                ast_boolean is_sub_node = AST_FALSE;
                for(int j = 0; j < current_node->sub_nodes->items; j++){
                    ast_pipeline_tree* sub_node = ast_list_get(current_node->sub_nodes, j);
                    if(strcmp(sub_node->module_name->identifier, inst_name) == 0){
                        ast_list_append(sub_node->instances, instantiation);
                        is_sub_node = AST_TRUE;
                        verilog_net_module_check(instantiation->declaration, sub_node);
                        break;
                    }
                }
                if(is_sub_node == AST_FALSE){
                    ast_pipeline_tree* sub_node = ast_calloc(1, sizeof(ast_pipeline_tree));
                    sub_node->instances = ast_list_new();
                    ast_list_append(sub_node->instances, instantiation);
                    sub_node->module_name = ast_new_identifier(inst_name, 0);
                    sub_node->sub_nodes = ast_list_new();
                    sub_node->parent = current_node;
                    ast_list_append(current_node->sub_nodes, sub_node);

                    verilog_net_module_check(instantiation->declaration, sub_node);
                }

            }
        }

    }
}


/*!
@brief searches across an entire verilog source tree, verify the new defined syntax
*/
void verilog_new_syntax_check(verilog_source_tree * source) {
    unsigned int m;
    for(m = 0; m < source -> modules -> items; m++) {
        ast_module_declaration *module = ast_list_get(source->modules, m);
        verilog_single_module_check(module);
    }

    ast_pipeline_tree* root = NULL;
    for(m = 0; m < source -> modules -> items; m++) {
        ast_module_declaration *module = ast_list_get(source->modules, m);

        if(module->module_comment != NULL && (strcmp(module->module_comment->identifier, "this") == 0)) {
            root = ast_calloc(1, sizeof(ast_pipeline_tree));
            root->instances = ast_list_new();
            ast_module_instantiation* root_instance = ast_calloc(1, sizeof(ast_module_declaration));
            root_instance->declaration = module;
            ast_list_append(root->instances, root_instance);
            root->parent = NULL;
            root->module_name = ast_new_identifier("this", 0);
            root->sub_nodes = ast_list_new();
            verilog_net_module_check(module, root);
            break;
        }
    }

    if(root == NULL){
        printf("INFO> No root module found \n");
        exit(0);
    }
    assert(root != NULL);

    printf("INFO> start analysing pipeline structure\n");
    verilog_analysis_pipeline_tree(root);

    printf("INFO> start check verilog syntaxs\n");
    verilog_check_special_syntax(source, root);

}

void verilog_check_special_syntax(verilog_source_tree * source, ast_pipeline_tree* root){
    verilog_signal_singel_value_assignment_check(source);
    verilog_sequential_logic_check(source);
    verilog_condition_case_check(source);

}

void verilog_signal_singel_value_assignment_check(verilog_source_tree * source){
    printf("INFO> start check verilog signal assignment\n");
    ast_boolean found = AST_FALSE;

    for(int m = 0; m < source -> modules -> items; m++) {
        ast_module_declaration *module = ast_list_get(source->modules, m);
        for(int n = 0; n < module->signals_db->items; n++){
            ast_module_signal* signal = ast_list_get(module->signals_db, n);
            if(signal->assignment_times == -1){
                found = AST_TRUE;
                printf("Error> %s.%s is assigned more than once \n", module->identifier->identifier, signal->signal_name->identifier);
            }
        }
    }
    if(found == AST_FALSE){
        printf("INFO> Pass signal assignment check \n");
    }


}

void verilog_sequential_logic_check(verilog_source_tree * source){
    printf("INFO> start check verilog sequential assignment\n");

    ast_signal_dependency_type clk_type = SIGNAL_DEPENDENCY_CONCURRENT, rst_type = SIGNAL_DEPENDENCY_CONCURRENT;
    ast_boolean found = AST_FALSE;

    for (int i = 0; i < source->modules->items; i++) {
        ast_module_declaration* module = ast_list_get(source->modules, i);
        for (int m = 0; m < module->always_blocks->items; m++) {
            ast_statement_block *always_block = ast_list_get(module->always_blocks, m);
            assert(always_block->type == BLOCK_SEQUENTIAL_ALWAYS);

            ast_timing_control_statement *trigger = always_block->trigger;
            if (trigger == NULL) {
            } else {
                switch (trigger->type) {
                    case TIMING_CTRL_EVENT_CONTROL: {
                        switch (trigger->event_ctrl->type) {
                            case EVENT_CTRL_TRIGGERS: {
                                ast_event_expression *always_block_sensitives = trigger->event_ctrl->expression;
                                ast_list *sensitives_list = ast_list_new();
                                ast_find_trigger_list(always_block_sensitives, module->signals_db, sensitives_list);


                                for(int k = 0; k < sensitives_list->items; k++){
                                    ast_signal_dependency* dependency = ast_list_get(sensitives_list, k);
                                    if(dependency->signal->signal_info_comment == NULL){
                                        continue;
                                    } else {
                                        if(strcmp(dependency->signal->signal_info_comment->identifier, "clock") == 0) {
                                            if (clk_type == SIGNAL_DEPENDENCY_CONCURRENT) {
                                                if (dependency->type == SIGNAL_DEPENDENCY_POSEDGE) {
                                                    clk_type = SIGNAL_DEPENDENCY_POSEDGE;
                                                } else if (dependency->type == SIGNAL_DEPENDENCY_NEGEDGE) {
                                                    clk_type = SIGNAL_DEPENDENCY_POSEDGE;
                                                } else {
                                                    found = AST_TRUE;
                                                    printf("Error> clock signal should be edge triggered\n");
                                                }
                                            } else {
                                                if(clk_type != dependency->type){
                                                    found = AST_TRUE;
                                                    printf("Error> clock signal should be all triggered by posedge or negedge\n");
                                                }
                                            }
                                        } else if(strcmp(dependency->signal->signal_info_comment->identifier, "reset") == 0) {
                                            if (rst_type == SIGNAL_DEPENDENCY_CONCURRENT) {
                                                if (dependency->type == SIGNAL_DEPENDENCY_POSEDGE) {
                                                    rst_type = SIGNAL_DEPENDENCY_POSEDGE;
                                                } else if (dependency->type == SIGNAL_DEPENDENCY_NEGEDGE) {
                                                    rst_type = SIGNAL_DEPENDENCY_POSEDGE;
                                                } else if (dependency->type == SIGNAL_DEPENDENCY_ANY) {
                                                    rst_type = SIGNAL_DEPENDENCY_ANY;
                                                } else {
                                                    found = AST_TRUE;
                                                    printf("Error> reset signal should be edge triggered\n");
                                                }
                                            } else {
                                                if(rst_type != dependency->type){
                                                    found = AST_TRUE;
                                                    printf("Error> reset signal should be all triggered by posedge or negedge or both\n");
                                                }
                                            }

                                        }
                                    }
                                    if(dependency->type != SIGNAL_DEPENDENCY_CONCURRENT){

                                    }
                                }
                                break;
                            }
                            case EVENT_CTRL_ANY: {

                                break;
                            }
                            default: {
                                // similar to continuous assignment
                                printf("unimplemented ctrl type %d\n", trigger->event_ctrl->type);
                                assert(0);
                                break;
                            }
                        }
                        break;
                    }
                    default: {
                        assert(0);
                    }
                }
            }
        }
    }
    if(found == AST_FALSE){
        printf("INFO> Pass sequential trigger check \n");
    }

}

void verilog_condition_case_check(verilog_source_tree * source){
    printf("INFO> start check verilog condition case statement syntaxs\n");

    ast_boolean error = AST_FALSE;

    for (int i = 0; i < source->modules->items; i++) {
        ast_module_declaration *module = ast_list_get(source->modules, i);

        for (int m = 0; m < module->always_blocks->items; m++) {
            ast_statement_block *always_block = ast_list_get(module->always_blocks, m);
            assert(always_block->type == BLOCK_SEQUENTIAL_ALWAYS);

            ast_timing_control_statement *trigger = always_block->trigger;
            if (trigger == NULL) {
                ast_list *outside_assigns = ast_list_new();
                verilog_analysis_condition_case_statement(ast_list_get(always_block->statements, 0), module,
                        module->signals_db, outside_assigns, &error);
            } else {
                switch (trigger->type) {
                    case TIMING_CTRL_EVENT_CONTROL: {
                        switch (trigger->event_ctrl->type) {
                            case EVENT_CTRL_TRIGGERS: {
                                ast_event_expression *always_block_sensitives = trigger->event_ctrl->expression;
                                ast_list* outside_assigns = ast_list_new();
                                verilog_analysis_condition_case_statement(trigger->statement, module, module->signals_db,
                                        outside_assigns, &error);
                                break;
                            }
                            case EVENT_CTRL_ANY: {
                                ast_list *outside_assigns = ast_list_new();
                                verilog_analysis_condition_case_statement(trigger->statement, module, module->signals_db,
                                        outside_assigns, &error);

                                break;
                            }
                            default: {
                                // similar to continuous assignment
                                printf("unimplemented ctrl type %d\n", trigger->event_ctrl->type);
                                assert(0);
                                break;
                            }
                        }
                        break;
                    }
                    default: {
                        assert(0);
                    }
                }
            }
        }
    }

    if(error == AST_FALSE){
        printf("INFO> Pass condition case statement check\n");
    }

}
ast_list* verilog_analysis_condition_case_statement(ast_statement* statement, ast_module_declaration* module,
        ast_list* signals_db, ast_list* outside_assigns, ast_boolean* error){
    switch (statement->type) {
        case STM_CONDITIONAL:{
            ast_if_else *control_statement = (ast_if_else *)statement->conditional;

            ast_list* all_assignment = NULL;
            for(int i = 0; i < control_statement->conditional_statements->items; i++){
                ast_conditional_statement* c_statement = ast_list_get(control_statement->conditional_statements, i);
                ast_list* assign = verilog_analysis_condition_case_statement(c_statement->statement, module, signals_db, outside_assigns, error);
                if(all_assignment == NULL){
                    all_assignment = assign;
                } else {
                    if(verilog_compare_assignment_list(all_assignment, assign, outside_assigns) == AST_FALSE){
                        printf("Error> Conditional statement(end at line %d) in %s(%s) should provide assignment to a same set "
                               "of signals in every branch\n", statement->meta.line + 1, module->identifier->identifier, statement->meta.file);

                        printf("branch1:");
                        for(int j = 0; j < all_assignment->items; j++){
                            ast_module_signal* signal = ast_list_get(all_assignment, j);
                            printf(" %s", signal->signal_name->identifier);
                        }
                        printf("\n");
                        printf("branch%d:", i);
                        for(int j = 0; j < assign->items; j++){
                            ast_module_signal* signal = ast_list_get(assign, j);
                            printf(" %s", signal->signal_name->identifier);
                        }
                        printf("\n");
                        *error = AST_TRUE;
                        break;
                    }
                }
            }
            if(control_statement->else_condition != NULL){
                ast_list* assign = verilog_analysis_condition_case_statement(control_statement->else_condition, module,
                        signals_db, outside_assigns, error);
                if(verilog_compare_assignment_list(all_assignment, assign, outside_assigns) == AST_FALSE && error == AST_FALSE){
                    printf("Error> Conditional statement(end at line %d) in %s(%s) should provide assignment to a same set "
                           "of signals in every branch\n", statement->meta.line + 1, module->identifier->identifier, statement->meta.file);
                    printf("branch1:");
                    for(int i = 0; i < all_assignment->items; i++){
                        ast_module_signal* signal = ast_list_get(all_assignment, i);
                        printf(" %s", signal->signal_name->identifier);
                    }
                    printf("\n");
                    printf("branch%d:", control_statement->conditional_statements->items + 1);
                    for(int i = 0; i < assign->items; i++){
                        ast_module_signal* signal = ast_list_get(assign, i);
                        printf(" %s", signal->signal_name->identifier);
                    }
                    printf("\n");
                    *error = AST_TRUE;
                }

            }

            return all_assignment;
        }
        case STM_BLOCK: {

            assert(statement->block->type == BLOCK_SEQUENTIAL || statement->block->type == BLOCK_SEQUENTIAL_ALWAYS );
            ast_list* slist = statement->block->statements;

            ast_list *result = ast_list_new();

            if(slist == NULL) return result;

            for(int i = 0; i < slist->items; i++){
                ast_statement* s = ast_list_get(slist, i);
                ast_list* tmp_list = verilog_analysis_condition_case_statement(s, module, signals_db, result, error);

                if(tmp_list != NULL) ast_list_concat(result, tmp_list);
            }
            return result;
        }

        case STM_ASSIGNMENT: {
            switch (statement->assignment->type){
                case ASSIGNMENT_NONBLOCKING:{
                }
                case ASSIGNMENT_BLOCKING: {
//                    printf("lval %s\n", ast_list_get(statement->assignment->procedural->lval->data.concatenation->items, 0));

                    ast_list *primarys = ast_list_new();
                    ast_find_primary_from_expression(statement->assignment->procedural->expression, signals_db,
                                                     primarys);

                    ast_list *lvals = ast_list_new();
                    switch (statement->assignment->procedural->lval->type){
                        case NET_IDENTIFIER:
                        case VAR_IDENTIFIER: {
                            ast_list_append(lvals, statement->assignment->procedural->lval->data.identifier->identifier);
                            break;
                        }

                        case NET_CONCATENATION:
                        case VAR_CONCATENATION: {
                            ast_concatenation *concat = statement->assignment->procedural->lval->data.concatenation;
                            if(concat->repeat != NULL)
                                ast_list_append(lvals, concat->repeat->primary->value.identifier->identifier);

                            for(int i = 0; i < concat->items->items; i++){
                                ast_concatenation* ident = ast_list_get(concat->items, i);
                                ast_identifier ident2 = ast_list_get(ident->items, 0);
                                ast_list_append(lvals, ident2->identifier);
                            }

                            break;
                        }

                        default: {
                            assert(0);
                        }
                    }

                    ast_list* all_assignment = ast_list_new();
                    for(int i = 0; i < lvals->items; i++){
                        ast_module_signal *des_signal = NULL;
                        char* name = ast_list_get(lvals, i);

                        for (int j = 0; j < signals_db->items; j++) {
                            ast_module_signal *signal = ast_list_get(signals_db, j);
                            if (strcmp(signal->signal_name->identifier, name) == 0) {
                                des_signal = signal;
                            }
                        }

                        if (des_signal == NULL) {
                            printf("Error>Module %s assignment left value %s need to be defined early\n",
                                   module->identifier->identifier,
                                   statement->assignment->procedural->lval->data.identifier->identifier);
                            continue;
                        }
                        assert(des_signal != NULL);
                        ast_list_append(all_assignment, des_signal);

                    }
                    return all_assignment;
                }
                default: {
                    assert(0);
                }
            }
            return NULL;
        }

        case STM_TIMING_CONTROL:{
            // used for simulation, just neglect it
            return NULL;
        }
        case STM_CASE:{
            ast_case_statement* case_statement = statement->case_statement;
            ast_list* all_assignment = NULL;

            for(int i = 0; i < case_statement->cases->items; i++){
                ast_case_item* c_item = ast_list_get(case_statement->cases, i);
                if(c_item->body == NULL) continue;
                ast_list* assign = verilog_analysis_condition_case_statement(c_item->body, module, signals_db, outside_assigns, error);
                if(all_assignment == NULL){
                    all_assignment = assign;
                } else {
                    if(verilog_compare_assignment_list(all_assignment, assign, outside_assigns) == AST_FALSE){
                        printf("Error> Case statement(end at line %d) in %s(%s) should provide assignment to a same set "
                               "of signals in every case branch\n", statement->meta.line + 1, module->identifier->identifier, statement->meta.file);
                        printf("branch1:");
                        for(int j = 0; j < all_assignment->items; j++){
                            ast_module_signal* signal = ast_list_get(all_assignment, j);
                            printf(" %s", signal->signal_name->identifier);
                        }
                        printf("\n");
                        printf("branch%d:", i + 1);
                        for(int j = 0; j < assign->items; j++){
                            ast_module_signal* signal = ast_list_get(assign, j);
                            printf(" %s", signal->signal_name->identifier);
                        }
                        printf("\n");
                        *error = AST_TRUE;
                        break;
                    }
                }
            }
            return all_assignment;
        }
        case STM_FUNCTION_CALL: {

            return NULL;
        }
        default:{
            printf("Unsupported statement type: %d\n", statement->type);
            assert(0);
        }

    }
}
ast_boolean verilog_compare_assignment_list(ast_list* former_raw, ast_list* latter_raw, ast_list* outside_assigns){

    ast_list *former = ast_list_new(), *latter = ast_list_new();
    for(int i = 0; i < former_raw->items; i++){
        ast_boolean found = AST_FALSE;
        ast_module_signal *signal = ast_list_get(former_raw, i);
        for(int j = 0; j < former->items; j++){
            ast_module_signal *tmp_signal = ast_list_get(former, j);
            if(strcmp(tmp_signal->signal_name->identifier, signal->signal_name->identifier) == 0){
                found = AST_TRUE;
            }
        }
        if(found == AST_FALSE){
            ast_list_append(former, signal);
        }
    }

    for(int i = 0; i < latter_raw->items; i++){
        ast_boolean found = AST_FALSE;
        ast_module_signal *signal = ast_list_get(latter_raw, i);
        for(int j = 0; j < latter->items; j++){
            ast_module_signal *tmp_signal = ast_list_get(latter_raw, j);
            if(strcmp(tmp_signal->signal_name->identifier, signal->signal_name->identifier) == 0){
                found = AST_TRUE;
            }
        }
        if(found == AST_FALSE){
            ast_list_append(latter, signal);
        }
    }


    if(former->items > latter->items){
        ast_list* tmp_ptr = latter;
        latter = former;
        former = tmp_ptr;
    }

    for(int i = 0; i < former->items; i++){
        ast_module_signal* former_signal = ast_list_get(former, i);
        ast_boolean found = AST_FALSE;
        for(int j = 0; j < latter->items; j++){
            ast_module_signal* latter_signal = ast_list_get(latter, j);
            if(strcmp(former_signal->signal_name->identifier, latter_signal->signal_name->identifier) == 0){
                found = AST_TRUE;
            }
        }
        for(int j = 0; j < outside_assigns->items; j++){
            ast_module_signal* latter_signal = ast_list_get(outside_assigns, j);
            if(strcmp(former_signal->signal_name->identifier, latter_signal->signal_name->identifier) == 0){
                found = AST_TRUE;
            }
        }


        if(found == AST_FALSE){
            return AST_FALSE;
        }
    }
    return AST_TRUE;
}


ast_boolean check_in_signal(ast_module_instantiation *instance, ast_list* signals_db,
        ast_module_signal *module_signal, ast_pipeline_tree* node) {

    ast_module_instance* instance1 = ast_list_get(instance->module_instances, 0);
    ast_port_connection *portConnection = ast_list_get(instance1->port_connections, module_signal->index);
    ast_expression *des_exp = NULL;

    if (portConnection->port_name == NULL) {
        des_exp = portConnection->expression;
    } else {
        for (int k = 0; k < instance1->port_connections->items; k++) {
            ast_port_connection *des_port_conn = ast_list_get(instance1->port_connections, k);
            if (strcmp(des_port_conn->port_name->identifier,
                       module_signal->signal_name->identifier) == 0) {
                des_exp = des_port_conn->expression;
            }
        }
    }
    assert(des_exp != NULL);

    ast_list *primarys = ast_list_new();
    ast_find_primary_from_expression(des_exp, instance->module_ptr->signals_db, primarys);

    ast_boolean found_in_previous_instance = AST_FALSE;

    for (int k = 0; k < primarys->items; k++) {
        ast_signal_dependency *primary = ast_list_get(primarys, k);
        ast_list *depends = ast_list_new();
        ast_list *iter_path = ast_list_new();
        verilog_iter_dependency(primary->signal, instance->module_ptr->signals_db, iter_path, depends);

        for (int kk = 0; kk < depends->items; kk++) {
            ast_module_signal *dependency_signal = ast_list_get(depends, kk);
            if (instance->pre_instance == NULL) {
                for (int x = 0; x < node->sub_nodes->items; x++) {
                    ast_pipeline_tree *pipe_iter = ast_list_get(node->sub_nodes, x);
                    for (int xx = 0; xx < pipe_iter->instances->items; xx++) {
                        ast_module_instantiation *instance_iter = ast_list_get(pipe_iter->instances, xx);
                        if (strcmp(instance_iter->declaration->identifier->identifier,
                                   instance->declaration->identifier->identifier) == 0) {
                            continue;
                        }
                        ast_module_instance *instance1 = ast_list_get(
                                instance_iter->module_instances, 0);
                        for (int y = 0; y < instance1->port_connections->items; y++) {
                            ast_port_connection *port_connection_iter = ast_list_get(
                                    instance1->port_connections, y);
                            ast_list *primarys_iter = ast_list_new();
                            ast_find_primary_from_expression(port_connection_iter->expression,
                                                             instance->module_ptr->signals_db, primarys_iter);

                            for (int yy = 0; yy < primarys_iter->items; yy++) {
                                ast_signal_dependency *dependency_iter = ast_list_get(primarys_iter,
                                                                                      yy);
                                if (strcmp(dependency_iter->signal->signal_name->identifier,
                                           dependency_signal->signal_name->identifier) == 0) {
                                    instance->pre_instance = instance_iter;
                                }
                            }

                        }
                    }
                }
            }
            if(instance->pre_instance == NULL){
                printf("Error> Signal %s.%s has wrong dependency, it's not a  in_signal\n",
                       instance->declaration->identifier->identifier,
                       portConnection->port_name->identifier);
                return AST_FALSE;
            }
            ast_module_instance *instance2 = ast_list_get(instance->pre_instance->module_instances, 0);

            for (int y = 0; y < instance2->port_connections->items; y++) {
                ast_port_connection *port_connection_iter = ast_list_get(instance2->port_connections, y);
                ast_list *primarys_iter = ast_list_new();
                ast_find_primary_from_expression(port_connection_iter->expression, instance->module_ptr->signals_db,
                                                 primarys_iter);

                for (int yy = 0; yy < primarys_iter->items; yy++) {
                    ast_signal_dependency *dependency_iter = ast_list_get(primarys_iter, yy);
                    if (strcmp(dependency_iter->signal->signal_name->identifier,
                               dependency_signal->signal_name->identifier) == 0) {
                        for (int z = 0; z < instance->pre_instance->declaration->signals_db->items; z++) {
                            ast_module_signal *dep_iter = ast_list_get(
                                    instance->pre_instance->declaration->signals_db, z);
                            ast_boolean tmp1 = (port_connection_iter->port_name == NULL) && (dep_iter->index == y);
                            ast_boolean tmp2 = (port_connection_iter->port_name != NULL);
                            if (tmp2 == AST_TRUE) {
                                tmp2 = (strcmp(dep_iter->signal_name->identifier,
                                               port_connection_iter->port_name->identifier) == 0);
                            }
                            if (tmp1 || tmp2) {
                                if (dep_iter->signal_info_comment == NULL  || strcmp(dep_iter->signal_info_comment->identifier,
                                           "out_signal") != 0) {
                                    printf("Error> Signal %s.%s has wrong dependency, %s is not a pipeline out_signal\n",
                                            instance->declaration->identifier->identifier,
                                            portConnection->port_name->identifier,
                                           dependency_signal->signal_name->identifier);
                                } else {
                                    found_in_previous_instance = AST_TRUE;
                                }
                            }
                        }
                    }

                }
            }
        }
    }
    return found_in_previous_instance;
}

ast_boolean check_back_signal(ast_module_instantiation *instance, ast_list* signals_db,
                            ast_module_signal *module_signal, ast_pipeline_tree* node, char* name) {

    ast_module_instance* instance1 = ast_list_get(instance->module_instances, 0);
    ast_port_connection *portConnection = ast_list_get(instance1->port_connections, module_signal->index);
    ast_expression *des_exp = NULL;

    if (portConnection->port_name == NULL) {
        des_exp = portConnection->expression;
    } else {
        for (int k = 0; k < instance1->port_connections->items; k++) {
            ast_port_connection *des_port_conn = ast_list_get(instance1->port_connections, k);
            if (strcmp(des_port_conn->port_name->identifier,
                       module_signal->signal_name->identifier) == 0) {
                des_exp = des_port_conn->expression;
            }
        }
    }
    assert(des_exp != NULL);

    ast_list *primarys = ast_list_new();
    ast_find_primary_from_expression(des_exp, instance->module_ptr->signals_db, primarys);

    ast_boolean found_in_previous_instance = AST_FALSE;

    for (int k = 0; k < primarys->items; k++) {
        ast_signal_dependency *primary = ast_list_get(primarys, k);
        ast_list *depends = ast_list_new();
        ast_list* iter_path = ast_list_new();
        verilog_iter_dependency(primary->signal, instance->module_ptr->signals_db, iter_path, depends);

        ast_pipeline_tree* pre_pipeline = NULL;
        for (int kk = 0; kk < depends->items; kk++) {
            ast_module_signal *dependency_signal = ast_list_get(depends, kk);
            for (int x = 0; x < node->sub_nodes->items; x++) {
                ast_pipeline_tree *pipe_iter = ast_list_get(node->sub_nodes, x);

                if((pipe_iter->module_name->identifier != NULL) && (strcmp(pipe_iter->module_name->identifier, name) == 0)) {
                    pre_pipeline = pipe_iter;
                }
            }
            if(pre_pipeline == NULL){
                printf("Error>%s.%s can't find %s\n", instance->declaration->identifier->identifier,  portConnection->port_name->identifier, name);
                return 0;
            }


            for(int x = 0; x < pre_pipeline->instances->items; x++) {
                ast_module_instantiation* pre_instance = ast_list_get(pre_pipeline->instances, x);

                ast_module_instance *instance2 = ast_list_get(pre_instance->module_instances, 0);

                for (int y = 0; y < instance2->port_connections->items; y++) {
                    ast_port_connection *port_connection_iter = ast_list_get(instance2->port_connections, y);
                    ast_list *primarys_iter = ast_list_new();
                    ast_find_primary_from_expression(port_connection_iter->expression, instance->module_ptr->signals_db,
                                                     primarys_iter);

                    for (int yy = 0; yy < primarys_iter->items; yy++) {
                        ast_signal_dependency *dependency_iter = ast_list_get(primarys_iter, yy);
                        if (strcmp(dependency_iter->signal->signal_name->identifier,
                                   dependency_signal->signal_name->identifier) == 0) {
                           // found_in_previous_instance = AST_TRUE;
                            for (int z = 0; z < pre_instance->declaration->signals_db->items; z++) {
                                ast_module_signal *dep_iter = ast_list_get(
                                        pre_instance->declaration->signals_db, z);

                                ast_boolean tmp0 = (dep_iter->direction == PORT_OUTPUT);
                                ast_boolean tmp1 = (port_connection_iter->port_name == NULL) && (dep_iter->index == y);
                                ast_boolean tmp2 = (port_connection_iter->port_name != NULL);
                                if (tmp2 == AST_TRUE) {
                                    tmp2 = (strcmp(dep_iter->signal_name->identifier,
                                                   port_connection_iter->port_name->identifier) == 0);
                                }
                                if ((tmp1 || tmp2) && tmp0) {
                                 //   printf("foudn %s\n", dep_iter->signal_name->identifier);
//                                    if (dep_iter->signal_info_comment == NULL || strcmp(dep_iter->signal_info_comment->identifier, "out_signal") != 0) {
//                                        printf("Error> %s.%s has wrong dependency, %s is not a pipeline out_signal\n",
//                                               instance->declaration->identifier->identifier,
//                                               portConnection->port_name->identifier,
//                                               dep_iter->signal_name->identifier);
//                                    } else {
                                        found_in_previous_instance = AST_TRUE;
//                                    }
                                }
                            }
                        }

                    }
                }
            }
        }
    }
    return found_in_previous_instance;
}

void verilog_analysis_pipeline_tree(ast_pipeline_tree* node){
    if(node->sub_nodes->items != 0){
        printf("%s\n", node->module_name->identifier);

        for(int ii = 0; ii < node->sub_nodes->items; ii++) {
            ast_pipeline_tree* sub_node = ast_list_get(node->sub_nodes, ii);
            for (int i = 0; i < sub_node->instances->items; i++) {
                ast_module_instantiation *instance = ast_list_get(sub_node->instances, i);
                ast_list *signals_db = instance->declaration->signals_db;
                for (int j = 0; j < signals_db->items; j++) {
                    ast_module_signal *module_signal = ast_list_get(signals_db, j);
                    if (module_signal->signal_info_comment == NULL)
                        continue;
                    if (strcmp(module_signal->signal_info_comment->identifier, "in_signal") == 0) {
                        if(check_in_signal(instance, signals_db, module_signal, node) == AST_TRUE){
                            printf("INFO>%s.%s has right dependency\n",
                                    instance->declaration->identifier->identifier,
                                    module_signal->signal_name->identifier);
                        } else {
                            printf("Error>%s.%s has wrong dependency\n",
                                    instance->declaration->identifier->identifier,
                                    module_signal->signal_name->identifier );

                        }


                    } else if (strcmp(module_signal->signal_info_comment->identifier, "out_signal") == 0) {

                    } else if (strncmp(module_signal->signal_info_comment->identifier, "back ", 5) == 0){
                        char* name = module_signal->signal_info_comment->identifier + 5;
                        if(check_back_signal(instance, signals_db, module_signal, node, name) == AST_TRUE){
                            printf("INFO>%s.%s has right dependency\n",
                                   instance->declaration->identifier->identifier,
                                   module_signal->signal_name->identifier);
                        } else {
                            printf("Error>%s.%s has wrong dependency, it's not back from %s\n",
                                   instance->declaration->identifier->identifier,
                                   module_signal->signal_name->identifier, name);

                        }


                    }
                }
            }
        }

        for(int i = 0 ; i < node->sub_nodes->items; i++){
            ast_pipeline_tree* subnode = ast_list_get(node->sub_nodes, i);
            verilog_analysis_pipeline_tree(subnode);
        }

    } else {
        printf("leaf node : %s\n", node->module_name->identifier);
        ast_boolean has_in_signal = AST_FALSE;
        for(int i = 0; i < node->instances->items; i++){
            ast_module_instantiation* instance = ast_list_get(node->instances, i);
            for(int j = 0; j < instance->declaration->signals_db->items; j++){
                ast_module_signal* signal_dep = ast_list_get(instance->declaration->signals_db, j);
                if(signal_dep->signal_info_comment != NULL &&((strcmp(signal_dep->signal_info_comment->identifier, "in_signal") == 0)
                || (strncmp(signal_dep->signal_info_comment->identifier, "back ", 5) == 0))) {
                    has_in_signal = AST_TRUE;
                }
            }
        }

        for(int i = 0; i < node->instances->items; i++){
            ast_module_instantiation* instance = ast_list_get(node->instances, i);
            if(instance->declaration->module_comment_attributes != NULL &&
                strcmp(instance->declaration->module_comment_attributes->identifier, "no_check") == 0) {
                printf("INFO> neglect to check %s\n", instance->declaration->identifier->identifier);
                continue;
            }
            for(int j = 0; j < instance->declaration->signals_db->items; j++){
                ast_module_signal* signal_dep = ast_list_get(instance->declaration->signals_db, j);
                if(signal_dep->signal_info_comment != NULL &&(strcmp(signal_dep->signal_info_comment->identifier, "out_signal") == 0)){
                    ast_list* result = ast_list_new();
                    ast_list* signals = ast_list_new();
                    verilog_iter_module_dependency(instance, signal_dep, signals, AST_TRUE, node, result);
                    ast_list* remove_dup_result = ast_list_new();
                    for(int ii = 0; ii < result->items; ii++){
                        ast_module_signal* signal = ast_list_get(result, ii);
                        ast_boolean found = AST_FALSE;
                        for(int jj = 0; jj < remove_dup_result->items; jj++){
                            ast_module_signal *tmp_signal = ast_list_get(remove_dup_result, jj);
                            if(strcmp(tmp_signal->signal_name->identifier, signal->signal_name->identifier) == 0){
                                found = AST_TRUE;
                            }
                        }
                        if(found == AST_FALSE){
                            ast_list_append(remove_dup_result, signal);
                        }
                    }



                    ast_boolean clk_found = AST_FALSE, rst_found = AST_FALSE, in_signal_found = AST_FALSE;
                    for(int k = 0; k < remove_dup_result->items; k++){
                        ast_module_signal* signal = ast_list_get(remove_dup_result, k);

                        if(signal->signal_info_comment == NULL) continue;
                        if(strcmp(signal->signal_info_comment->identifier, "clock") == 0){
                            clk_found = AST_TRUE;
                        } else if(strcmp(signal->signal_info_comment->identifier, "reset") == 0) {
                            rst_found = AST_TRUE;
                        } else if((strcmp(signal->signal_info_comment->identifier, "in_signal") == 0)
                                  || (strncmp(signal->signal_info_comment->identifier, "back ", 5) == 0)) {
                            in_signal_found = AST_TRUE;
                        }
                    }


                    if(clk_found && rst_found && (in_signal_found || !has_in_signal))
                        printf("INFO>%s.%s has right dependency\n",
                                instance->declaration->identifier->identifier,
                                signal_dep->signal_name->identifier);
                    else {
                        printf("Error>%s.%s has wrong dependency, %s%s%s\n",
                               instance->declaration->identifier->identifier,
                               signal_dep->signal_name->identifier,
                               clk_found == AST_TRUE ? "" : "it doesn't depends on clock, ",
                               rst_found == AST_TRUE ? "" : "it doesn't depends on reset, ",
                               in_signal_found == AST_TRUE ? "" : "it doesn't depends on in_signal, ");
                        for (int k = 0; k < remove_dup_result->items; k++) {
                            ast_module_signal *signal = ast_list_get(remove_dup_result, k);
                            printf("%s ", signal->signal_name->identifier);
                        }
                        printf("\n");
                    }
                }
            }

        }
    }
}

void verilog_iter_module_dependency(ast_module_instantiation* instance, ast_module_signal* signal, ast_list* signals,
        ast_boolean is_in_module, ast_pipeline_tree* node, ast_list* module_result){
   // printf("iter %s %s\n", instance->declaration->identifier->identifier, signal->signal_name->identifier);
    ast_list_append(signals, signal);
    if(is_in_module == AST_TRUE){
        ast_list* result = ast_list_new();
        ast_list* iter_path = ast_list_new();
        verilog_iter_dependency(signal, instance->declaration->signals_db, iter_path, result);
        for(int i = 0; i < result->items; i++){
            ast_module_signal* depend = ast_list_get(result, i);
            if(depend->signal_info_comment == NULL){
                verilog_iter_module_dependency(instance, depend, signals, AST_FALSE, node, module_result);
            } else if(strcmp(depend->signal_info_comment->identifier, "clock") == 0){
                ast_list_append(module_result, depend);
            } else if(strcmp(depend->signal_info_comment->identifier, "reset") == 0){
                ast_list_append(module_result, depend);
            } else {
                verilog_iter_module_dependency(instance, depend, signals, AST_FALSE, node, module_result);
            }

        }
    } else {

        ast_module_declaration* parent_dec = instance->module_ptr;
        ast_module_instantiation* instantiation = instance;

        ast_module_instance* instance1 =  ast_list_get(instantiation->module_instances, 0);

//        for(int j = 0; j < instance1->port_connections->items; j++){
            ast_port_connection *portConnection = ast_list_get(instance1->port_connections, signal->index);
            ast_expression *des_exp = NULL;

            if (portConnection->port_name == NULL) {
                des_exp = portConnection->expression;
            } else {
                for (int k = 0; k < instance1->port_connections->items; k++) {
                    ast_port_connection *des_port_conn = ast_list_get(instance1->port_connections, k);
                    if (strcmp(des_port_conn->port_name->identifier,
                               signal->signal_name->identifier) == 0) {
                        des_exp = des_port_conn->expression;
                    }
                }
            }
            assert(des_exp != NULL);
//
            ast_list *primarys = ast_list_new();
            ast_find_primary_from_expression(des_exp, parent_dec->signals_db, primarys);

            for (int k = 0; k < primarys->items; k++) {
                ast_signal_dependency *primary = ast_list_get(primarys, k);
                ast_list *depends = ast_list_new();
                ast_list *iter_path = ast_list_new();
                verilog_iter_dependency(primary->signal, parent_dec->signals_db, iter_path, depends);

                for (int kk = 0; kk < depends->items; kk++) {
                    ast_module_signal *dependency_signal = ast_list_get(depends, kk);

                    ast_pipeline_tree *pipe_iter = node;
                    ast_boolean found_in_other = AST_FALSE;
                    for (int xx = 0; xx < pipe_iter->instances->items; xx++) {
                        ast_module_instantiation *instance_iter = ast_list_get(pipe_iter->instances, xx);
                        if (strcmp(instance_iter->declaration->identifier->identifier,
                                   instance->declaration->identifier->identifier) == 0) {
                            continue;
                        }

                        ast_module_instance *instance2 = ast_list_get(
                                instance_iter->module_instances, 0);
                        for (int y = 0; y < instance2->port_connections->items; y++) {
                            ast_port_connection *port_connection_iter = ast_list_get(
                                    instance2->port_connections, y);
                            ast_list *primarys_iter = ast_list_new();
                            ast_find_primary_from_expression(port_connection_iter->expression,
                                                             instance->module_ptr->signals_db, primarys_iter);

                            for (int yy = 0; yy < primarys_iter->items; yy++) {
                                ast_signal_dependency *dependency_iter = ast_list_get(primarys_iter,
                                                                                      yy);
                                if(dependency_iter->signal->direction == PORT_INPUT) continue;

                                if (strcmp(dependency_iter->signal->signal_name->identifier,
                                           dependency_signal->signal_name->identifier) == 0) {
                                    found_in_other = AST_TRUE;
                                    for(int z = 0; z < instance_iter->declaration->signals_db->items; z++){
                                        ast_module_signal* tmp_signal = ast_list_get(instance_iter->declaration->signals_db, z);

                                        if(port_connection_iter->port_name == NULL) {
                                            if(tmp_signal->index == y){
                                                ast_boolean dup = AST_FALSE;
                                                for(int zz = 0; zz < signals->items; zz++){
                                                    ast_module_signal* tttmp_signal = ast_list_get(signals, zz);
                                                    if(strcmp(tttmp_signal->signal_name->identifier, tmp_signal->signal_name->identifier) == 0 &&
                                                       strcmp(tttmp_signal->module_name->identifier, tmp_signal->module_name->identifier) == 0){
                                                        dup = AST_TRUE;
                                                    }
                                                }
                                                if(dup == AST_FALSE)
                                                    verilog_iter_module_dependency(instance_iter, tmp_signal, signals, AST_TRUE,  node, module_result);

                                            }

                                        } else {
                                            if(strcmp(tmp_signal->signal_name->identifier, port_connection_iter->port_name->identifier) == 0){
                                                ast_boolean dup = AST_FALSE;
                                                for(int zz = 0; zz < signals->items; zz++){
                                                    ast_module_signal* tttmp_signal = ast_list_get(signals, zz);
                                                    if(strcmp(tttmp_signal->signal_name->identifier, tmp_signal->signal_name->identifier) == 0 &&
                                                       strcmp(tttmp_signal->module_name->identifier, tmp_signal->module_name->identifier) == 0){
                                                        dup = AST_TRUE;
                                                    }
                                                }
                                                if(dup == AST_FALSE)
                                                    verilog_iter_module_dependency(instance_iter, tmp_signal, signals, AST_TRUE,  node, module_result);

                                            }
                                        }


                                    }
                                }
                            }
                        }
                    }
                    if(found_in_other == AST_FALSE) {
                        ast_list_append(module_result, signal);
                    }
                }
            }

//        }
    }

    ast_list_remove_at(signals, signals->items - 1);
}


void verilog_iter_dependency(ast_module_signal* signal, ast_list* signals_db, ast_list* iter_path, ast_list* result){
    ast_list_append(iter_path, signal);
    if (signal->dependency->items == 0){
        ast_boolean found = AST_FALSE;
        for(int i = 0; i < result->items; i++){
            ast_module_signal* module_signal = ast_list_get(result, i);
            if(strcmp(module_signal->signal_name->identifier, signal->signal_name->identifier) == 0){
                found = AST_TRUE;
            }
        }
        if(found == AST_FALSE){
            ast_list_append(result, signal);
        }
    } else {
        for(int m = 0; m < signal->dependency->items; m++){
            ast_signal_dependency* depend = ast_list_get(signal->dependency, m);
            ast_boolean found = AST_FALSE;
            for(int i = 0; i < iter_path->items; i++){
                ast_module_signal* module_signal = ast_list_get(iter_path, i);
                if(strcmp(module_signal->signal_name->identifier, depend->signal->signal_name->identifier) == 0){
                    found = AST_TRUE;
                }
            }
            if(found == AST_FALSE){
                verilog_iter_dependency(depend->signal, signals_db, iter_path, result);
            }

        }
    }
}


ast_module_signal* ast_port_reference_to_module_signal(ast_port_reference* ref){
    ast_module_signal * tr = ast_calloc(1,sizeof(ast_module_signal));
    tr->direction = ref->direction;
    tr->signal_name = ref->port_name;
    tr->signal_info_comment = ref->port_info_comment;
    tr->dependency = ast_list_new();
    tr->assignment_times = 0;

    if(ref->is_reg == AST_TRUE){
        tr->declaration_type =  DECLARE_REG;
        tr->range = ref->range;
        tr->is_signed = ref->net_signed;
    } else {
        tr->declaration_type = DECLARE_NET;
        tr->range = ref->range;
        tr->net_type = ref->net_type;
        tr->is_signed = ref->net_signed;
    }

}

ast_module_signal* ast_net_declaration_to_module_signal(ast_net_declaration* dec){
    ast_module_signal * tr = ast_calloc(1,sizeof(ast_module_signal));

    tr->direction = PORT_INTERNAL;
    tr->declaration_type = DECLARE_NET;
    tr->range = dec->range;
    tr->net_type = dec->type;

    tr->is_signed = dec->is_signed;
    tr->signal_name = dec->identifier;
    tr->dependency = ast_list_new();
    tr->value = dec->value;
    tr->assignment_times = 0;

}

ast_module_signal* ast_reg_declaration_to_module_signal(ast_reg_declaration* dec){
    ast_module_signal * tr = ast_calloc(1,sizeof(ast_module_signal));

    tr->direction = PORT_INTERNAL;
    tr->declaration_type = DECLARE_REG;
    tr->range = dec->range;
    tr->is_signed = dec->is_signed;
    tr->signal_name = dec->identifier;
    tr->dependency = ast_list_new();
    tr->value = dec->value;
    tr->assignment_times = 0;

}

void print_signal_list(ast_module_declaration *module, ast_list* signals){
    printf("INFO> %s signal list:\n", module->identifier->identifier);
    for(int i = 0; i < signals->items; i++){
        ast_module_signal* signal = ast_list_get(signals, i);
        printf("%s ", signal->signal_name->identifier);
        switch (signal->direction){
            case PORT_INPUT: printf("INPUT "); break;
            case PORT_OUTPUT: printf("OUTPUT "); break;
            case PORT_INOUT: printf("INOUT "); break;
            case PORT_NONE:
            case PORT_INTERNAL:    printf("INTERNAL ");break;
        }
        switch (signal->declaration_type){
            case DECLARE_REG: printf("Reg, ");break;
            case DECLARE_NET: {
                switch (signal->net_type){
                    case NET_TYPE_WIRE:
                        printf("Wire, ");break;
                    case NET_TYPE_NONE:
                        printf("default Wire, "); break;
                    default:
                        printf("other types, ");break;
                }
                break;
            }
            default:
                printf("other types, ");break;

        }
        if(signal->signal_info_comment != NULL){
            printf("Comment: %s, ", signal->signal_info_comment->identifier);
        }
        if(signal->dependency != NULL){
            printf("Dependency: ");
            for(int j = 0; j < signal->dependency->items; j++){
                ast_signal_dependency* signal_dep = ast_list_get(signal->dependency, j);
                printf("%d %s, ", signal_dep->type, signal_dep->signal->signal_name->identifier);
            }
            printf("\n");
        }
        printf("\n");
    }
}

void analysis_signal_dependency(int statement_idx, ast_statement* statement, ast_list* signals_db , ast_list* current_sensitives){
//    printf("analysis signal dependency -> statement type: %d\n", statement->type);
    switch (statement->type) {
        case STM_CONDITIONAL:{
            ast_if_else *control_statement = (ast_if_else *)statement->conditional;
            int start = current_sensitives->items;

            for(int i = 0; i < control_statement->conditional_statements->items; i++){
                ast_conditional_statement* c_statement = ast_list_get(control_statement->conditional_statements, i);
//                printf("condition type: %d  statement type %d \n",
//                        c_statement->condition->type, c_statement->statement->type);
                ast_list* primarys = ast_list_new();
                ast_find_primary_from_expression(c_statement->condition, signals_db, primarys);

                for(int j = 0; j < primarys->items; j++){
                    ast_signal_dependency* primary = ast_list_get(primarys, j);
                    ast_boolean found = AST_FALSE;

                    for(int k = 0; k < current_sensitives->items; k++){
                        ast_signal_dependency* old_dep = ast_list_get(current_sensitives, k);
                        if(strcmp(old_dep->signal->signal_name->identifier, primary->signal->signal_name->identifier) == 0){
                            found = AST_TRUE;
                        }
                    }
                    if(found == AST_FALSE){
                        ast_list_append(current_sensitives, primary);
                    }
                }
                analysis_signal_dependency(statement_idx, c_statement->statement, signals_db, current_sensitives);

            }
            if(control_statement->else_condition != NULL){
                analysis_signal_dependency(statement_idx, control_statement->else_condition, signals_db, current_sensitives);
            }

            int end = current_sensitives->items;
            for(int j = start; j < end; j++){
                ast_list_remove_at(current_sensitives, start);
            }

            break;
        }
        case STM_BLOCK: {

            assert(statement->block->type == BLOCK_SEQUENTIAL || statement->block->type == BLOCK_SEQUENTIAL_ALWAYS );
            ast_list* slist = statement->block->statements;
            if(slist == NULL) break;
            for(int i = 0; i < slist->items; i++){
                ast_statement* s = ast_list_get(slist, i);
                analysis_signal_dependency(statement_idx, s, signals_db, current_sensitives);
            }
            break;
        }

        case STM_ASSIGNMENT: {
            switch (statement->assignment->type){
                case ASSIGNMENT_NONBLOCKING:{
                }
                case ASSIGNMENT_BLOCKING: {
//                    printf("lval %s\n", ast_list_get(statement->assignment->procedural->lval->data.concatenation->items, 0));

                    ast_list *primarys = ast_list_new();
                    ast_find_primary_from_expression(statement->assignment->procedural->expression, signals_db,
                                                     primarys);

                    ast_list *lvals = ast_list_new();
                    switch (statement->assignment->procedural->lval->type){
                        case NET_IDENTIFIER:
                        case VAR_IDENTIFIER: {
                            ast_list_append(lvals, statement->assignment->procedural->lval->data.identifier->identifier);
                            break;
                        }

                        case NET_CONCATENATION:
                        case VAR_CONCATENATION: {
                            ast_concatenation *concat = statement->assignment->procedural->lval->data.concatenation;
                            if(concat->repeat != NULL)
                                ast_list_append(lvals, concat->repeat->primary->value.identifier->identifier);

                            for(int i = 0; i < concat->items->items; i++){
                                ast_concatenation* ident = ast_list_get(concat->items, i);
                                ast_identifier ident2 = ast_list_get(ident->items, 0);
                                ast_list_append(lvals, ident2->identifier);
                            }

                            break;
                        }

                        default: {
                            assert(0);
                        }
                    }

                    for(int i = 0; i < lvals->items; i++){
                        ast_module_signal *des_signal = NULL;
                        char* name = ast_list_get(lvals, i);

                        for (int j = 0; j < signals_db->items; j++) {
                            ast_module_signal *signal = ast_list_get(signals_db, j);
                            if (strcmp(signal->signal_name->identifier, name) == 0) {
                                des_signal = signal;
                            }
                        }

                        if (des_signal == NULL) {
                            printf("Error> assignment left value %s need to be defined early\n",
                                   statement->assignment->procedural->lval->data.identifier->identifier);
                            continue;
                        }
                        assert(des_signal != NULL);

                        for (int j = 0; j < primarys->items; j++) {
                            ast_signal_dependency *primary = ast_list_get(primarys, j);
                            ast_boolean found = AST_FALSE;

                            for (int k = 0; k < des_signal->dependency->items; k++) {
                                ast_signal_dependency *old_dep = ast_list_get(des_signal->dependency, k);
                                if (strcmp(old_dep->signal->signal_name->identifier,
                                           primary->signal->signal_name->identifier) == 0) {
                                    found = AST_TRUE;
                                }
                            }
                            if (found == AST_FALSE) {
                                if(des_signal->assignment_times == 0){
                                    des_signal->assignment_times = statement_idx;
                                } else {
                                    des_signal->assignment_times = des_signal->assignment_times == statement_idx? statement_idx: -1;
                                }
                                ast_list_append(des_signal->dependency, primary);
                            }
                        }

                        for (int j = 0; j < current_sensitives->items; j++) {
                            ast_signal_dependency *primary = ast_list_get(current_sensitives, j);
                            ast_boolean found = AST_FALSE;

                            for (int k = 0; k < des_signal->dependency->items; k++) {
                                ast_signal_dependency *old_dep = ast_list_get(des_signal->dependency, k);
                                if (strcmp(old_dep->signal->signal_name->identifier,
                                           primary->signal->signal_name->identifier) == 0) {
                                    found = AST_TRUE;
                                }
                            }
                            if (found == AST_FALSE) {
                                ast_list_append(des_signal->dependency, primary);
                            }
                        }
                    }
                    break;
                }
                default: {
                    assert(0);
                }
            }
            break;
        }

        case STM_TIMING_CONTROL:{
            // used for simulation, just neglect it
            break;
        }
        case STM_CASE:{
            ast_case_statement* case_statement = statement->case_statement;
            int start = current_sensitives->items;

            ast_list* primarys = ast_list_new();
            ast_find_primary_from_expression(case_statement->expression, signals_db, primarys);
            for(int j = 0; j < primarys->items; j++){
                ast_signal_dependency* primary = ast_list_get(primarys, j);
                ast_boolean found = AST_FALSE;

                for(int k = 0; k < current_sensitives->items; k++){
                    ast_signal_dependency* old_dep = ast_list_get(current_sensitives, k);
                    if(strcmp(old_dep->signal->signal_name->identifier, primary->signal->signal_name->identifier) == 0){
                        found = AST_TRUE;
                    }
                }
                if(found == AST_FALSE){
                    ast_list_append(current_sensitives, primary);
                }
            }


            for(int i = 0; i < case_statement->cases->items; i++){
                ast_case_item* c_item = ast_list_get(case_statement->cases, i);
                if(c_item->body != NULL)
                    analysis_signal_dependency(statement_idx, c_item->body, signals_db, current_sensitives);
            }

            int end = current_sensitives->items;
            for(int j = start; j < end; j++){
                ast_list_remove_at(current_sensitives, start);
            }
            break;
        }
        case STM_FUNCTION_CALL: {

            break;
        }
        default:{
            printf("Unsupported statement type: %d\n", statement->type);
            assert(0);
        }

    }
}
