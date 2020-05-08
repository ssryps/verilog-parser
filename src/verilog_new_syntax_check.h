//
// Created by mason on 3/8/20.
//

#ifndef VERILOG_PARSER_VERILOG_NEW_SYNTAX_CHECK_H
#define VERILOG_PARSER_VERILOG_NEW_SYNTAX_CHECK_H

#include "verilog_ast.h"
#include "verilog_ast_util.h"


typedef struct ast_module_signal_t{
    ast_metadata    meta;   //!< Node metadata.
    ast_port_direction  direction;      //!< Input / output / inout etc.
    ast_identifier      signal_info_comment; //!< The comment for mark
    ast_declaration_type declaration_type;
    ast_range         * range;          //!< Bus width.
    ast_identifier      signal_name;      //!< Tast_identifier      port_name; //!< The comment for mark

    ast_net_type        net_type;       //!< Wire/reg etc
    ast_boolean         is_signed;     //!< Signed value?
    ast_delay3         * delay;      //!< Delay characteristics.
    ast_drive_strength * drive;      //!< Drive strength.
    ast_boolean          vectored;
    ast_boolean          scalared;


    ast_expression     * value;      //!< Default assigned value.
    ast_list           * dependency; //!< list of ast_signal_dependency
    int index;
    int assignment_times;
    ast_identifier module_name;
} ast_module_signal;

typedef enum ast_signal_dependency_type_t {
    SIGNAL_DEPENDENCY_CONCURRENT,
    SIGNAL_DEPENDENCY_POSEDGE,
    SIGNAL_DEPENDENCY_NEGEDGE,
    SIGNAL_DEPENDENCY_ANY,
}ast_signal_dependency_type;

typedef struct ast_signal_dependency_t {
    ast_signal_dependency_type type;
    ast_module_signal* signal;
} ast_signal_dependency;



ast_module_signal* ast_port_reference_to_module_signal(ast_port_reference* ref);
ast_module_signal* ast_net_declaration_to_module_signal(ast_net_declaration* dec);
ast_module_signal* ast_reg_declaration_to_module_signal(ast_reg_declaration* dec);
void print_signal_list(ast_module_declaration *module, ast_list* signals);
void ast_find_trigger_list(ast_event_expression* exp, ast_list* signals_db, ast_list* list);
void analysis_signal_dependency(int statemetn_idx, ast_statement* statement, ast_list* singals_db, ast_list* current_sensitives);
void ast_find_primary_from_expression(ast_expression* exp, ast_list* signals_db, ast_list* result);


typedef struct ast_pipeline_tree_t {
    ast_list* sub_nodes;
    ast_identifier module_name;
    ast_list* instances;
    struct ast_pipeline_tree_t* parent;
} ast_pipeline_tree;


void verilog_single_module_check(ast_module_declaration *module);
void verilog_net_module_check(ast_module_declaration *module, ast_pipeline_tree* current_node);
void verilog_new_syntax_check(verilog_source_tree * source);
void verilog_analysis_pipeline_tree(ast_pipeline_tree* node);
void verilog_check_special_syntax(verilog_source_tree* source, ast_pipeline_tree* root);
void verilog_signal_singel_value_assignment_check(verilog_source_tree * source);
void verilog_sequential_logic_check(verilog_source_tree * source);
void verilog_condition_case_check(verilog_source_tree * source);
ast_list* verilog_analysis_condition_case_statement(ast_statement* statement, ast_module_declaration* module,
        ast_list* signals_db, ast_list* outside_assigns);
ast_boolean verilog_compare_assignment_list(ast_list* former, ast_list* latter, ast_list* outside_assigns);

void verilog_iter_dependency(ast_module_signal* signal, ast_list* signals_db, ast_list* iter_path, ast_list* result);
void verilog_iter_module_dependency(ast_module_instantiation* instance, ast_module_signal* signal, ast_list* signals,
        ast_boolean is_in_module, ast_pipeline_tree* node, ast_list* module_result);
#endif //VERILOG_PARSER_VERILOG_NEW_SYNTAX_CHECK_H

