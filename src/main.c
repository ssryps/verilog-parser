/*!
@file main.c
@brief A simple test program for the C library code.
*/

#include "stdio.h"

#include "verilog_parser.h"
#include "verilog_ast_common.h"
#include "verilog_preprocessor.h"
#include "verilog_ast_util.h"
#include "verilog_cmd_parser.h"
#include "verilog_new_syntax_check.h"

/*!
@brief Prints the help text and exists, depending on the parameters.
*/
void print_help(boolean and_exit)
{
    printf("Usage: ./verilog-dot [args] [input files]\n");
    printf("Options:\n");
    printf("-h, --help    - Print this message and quit.\n");
    printf("[-I | --include] <FILE PATH> \n");
    printf("              - Specifiy the included header file. By default, \n");
    printf("                is the path of file to analyse.\n");
    printf("\n");

    if(and_exit){
        exit(0);
    }
}



/*!
@brief Responsible for parsing all of the command line arguments.
@returns A shell_args pointer
*/
shell_args * parse_args(int argc, char ** argv)
{
    if(argc == 1) {
        print_help(BOOL_TRUE);
    }

    shell_args * tr = calloc(1,sizeof(shell_args));
    tr->argc = argc;
    tr->argv = argv;

    int i;
    for(i = 1; i < argc; i++)
    {
        if(strcmp(argv[i], "-h")     == 0 ||
                strcmp(argv[i], "--help") == 0)
        {
            free(tr);
            print_help(BOOL_TRUE);
        }
        else if(strcmp(argv[i], "-I")       == 0 ||
                strcmp(argv[i], "--include") == 0)
        {
            tr -> include_dir_start = i;
            i++;
            while(i <= argc - 1){
                if(argv[i][0] == '-'){
                    i --;
                    break;
                } else {
                    tr -> include_dir_end = i;
                    i++;

                }
            }
        }
        else if(strcmp(argv[i], "-o")       == 0 ||
                strcmp(argv[i], "--output") == 0)
        {
            if(i < argc - 2 && argv[i][0] != '-')
            {
                i++;
                tr -> output_file_path = argv[i];
            }
        }
        else if(strcmp(argv[i], "-c")       == 0)
        {
            tr -> input_files_start = i;
            i++;
            while(i <= argc - 1){
                if(argv[i][0] == '-'){
                    i--;
                    break;
                } else {
                    tr -> input_files_end = i;
                    i++;
                }
            }

        }
    }

    if(tr -> output_file_path == NULL)
    {
        tr -> output_file_path = "graph.dot";
    }

    return tr;
}

void handle_include_dir(shell_args* args){
    printf("looking for header files in ");

    int i = 0;
    for(i = args->include_dir_start + 1; i <= args->include_dir_end; i++){
        // Setup the preprocessor to look in ./tests/ for include files.
        char* dir_path = args->argv[i];
        ast_list_append(yy_preproc -> search_dirs, dir_path);
        printf("%s", dir_path);
    }
    printf("\n");
}

int main(int argc, char ** argv)
{
    shell_args * args = parse_args(argc,argv);

    // Initialise the parser.
    verilog_parser_init();
    handle_include_dir(args);

    int i = 0;
    for(i = args->input_files_start + 1; i <= args->input_files_end; i++) {
        printf("INFO > Parsing %s \n", argv[i]);
        // Load the file.
        FILE * fh = fopen(argv[i], "r");

        verilog_preprocessor_set_file(yy_preproc, argv[i]);

        // Parse the file and store the result.
        int result = verilog_parse_file(fh);

        // Close the file handle
        fclose(fh);

        if(result == 0) {
            printf(" - Parse successful\n");
        } else {
            printf(" - Parse failed\n");
            if(argc<=2) return 1;
        }

        verilog_resolve_modules(yy_verilog_source_tree);
    }

    verilog_new_syntax_check(yy_verilog_source_tree);

    return 0;
}
