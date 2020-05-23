/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_HOME_MASON_DESKTOP_WORK_VERILOG_PARSER_CMAKE_BUILD_DEBUG_SRC_VERILOG_PARSER_TAB_H_INCLUDED
# define YY_YY_HOME_MASON_DESKTOP_WORK_VERILOG_PARSER_CMAKE_BUILD_DEBUG_SRC_VERILOG_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 26 "/home/mason/Desktop/work/verilog-parser/src/verilog_parser.y" /* yacc.c:1909  */

    #include "verilog_ast.h"

#line 48 "/home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/verilog_parser.tab.h" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ANY = 258,
    END = 259,
    NEWLINE = 260,
    SPACE = 261,
    TAB = 262,
    AT = 263,
    COMMA = 264,
    HASH = 265,
    DOT = 266,
    EQ = 267,
    COLON = 268,
    IDX_PRT_SEL = 269,
    SEMICOLON = 270,
    OPEN_BRACKET = 271,
    CLOSE_BRACKET = 272,
    OPEN_SQ_BRACKET = 273,
    CLOSE_SQ_BRACKET = 274,
    OPEN_SQ_BRACE = 275,
    CLOSE_SQ_BRACE = 276,
    BIN_VALUE = 277,
    OCT_VALUE = 278,
    HEX_VALUE = 279,
    DEC_BASE = 280,
    BIN_BASE = 281,
    OCT_BASE = 282,
    HEX_BASE = 283,
    NUM_REAL = 284,
    NUM_SIZE = 285,
    UNSIGNED_NUMBER = 286,
    SYSTEM_ID = 287,
    SIMPLE_ID = 288,
    ESCAPED_ID = 289,
    DEFINE_ID = 290,
    ATTRIBUTE_START = 291,
    ATTRIBUTE_END = 292,
    COMMENT_LINE = 293,
    COMMENT_BLOCK = 294,
    MODULE_COMMENT = 295,
    STRING = 296,
    STAR = 297,
    PLUS = 298,
    MINUS = 299,
    ASL = 300,
    ASR = 301,
    LSL = 302,
    LSR = 303,
    DIV = 304,
    POW = 305,
    MOD = 306,
    GTE = 307,
    LTE = 308,
    GT = 309,
    LT = 310,
    L_NEG = 311,
    L_AND = 312,
    L_OR = 313,
    C_EQ = 314,
    L_EQ = 315,
    C_NEQ = 316,
    L_NEQ = 317,
    B_NEG = 318,
    B_AND = 319,
    B_OR = 320,
    B_XOR = 321,
    B_EQU = 322,
    B_NAND = 323,
    B_NOR = 324,
    TERNARY = 325,
    UNARY_OP = 326,
    MACRO_TEXT = 327,
    MACRO_IDENTIFIER = 328,
    KW_ALWAYS = 329,
    KW_AND = 330,
    KW_ASSIGN = 331,
    KW_AUTOMATIC = 332,
    KW_BEGIN = 333,
    KW_BUF = 334,
    KW_BUFIF0 = 335,
    KW_BUFIF1 = 336,
    KW_CASE = 337,
    KW_CASEX = 338,
    KW_CASEZ = 339,
    KW_CELL = 340,
    KW_CMOS = 341,
    KW_CONFIG = 342,
    KW_DEASSIGN = 343,
    KW_DEFAULT = 344,
    KW_DEFPARAM = 345,
    KW_DESIGN = 346,
    KW_DISABLE = 347,
    KW_EDGE = 348,
    KW_ELSE = 349,
    KW_END = 350,
    KW_ENDCASE = 351,
    KW_ENDCONFIG = 352,
    KW_ENDFUNCTION = 353,
    KW_ENDGENERATE = 354,
    KW_ENDMODULE = 355,
    KW_ENDPRIMITIVE = 356,
    KW_ENDSPECIFY = 357,
    KW_ENDTABLE = 358,
    KW_ENDTASK = 359,
    KW_EVENT = 360,
    KW_FOR = 361,
    KW_FORCE = 362,
    KW_FOREVER = 363,
    KW_FORK = 364,
    KW_FUNCTION = 365,
    KW_GENERATE = 366,
    KW_GENVAR = 367,
    KW_HIGHZ0 = 368,
    KW_HIGHZ1 = 369,
    KW_IF = 370,
    KW_IFNONE = 371,
    KW_INCDIR = 372,
    KW_INCLUDE = 373,
    KW_INITIAL = 374,
    KW_INOUT = 375,
    KW_INPUT = 376,
    KW_INSTANCE = 377,
    KW_INTEGER = 378,
    KW_JOIN = 379,
    KW_LARGE = 380,
    KW_LIBLIST = 381,
    KW_LIBRARY = 382,
    KW_LOCALPARAM = 383,
    KW_MACROMODULE = 384,
    KW_MEDIUM = 385,
    KW_MODULE = 386,
    KW_NAND = 387,
    KW_NEGEDGE = 388,
    KW_NMOS = 389,
    KW_NOR = 390,
    KW_NOSHOWCANCELLED = 391,
    KW_NOT = 392,
    KW_NOTIF0 = 393,
    KW_NOTIF1 = 394,
    KW_OR = 395,
    KW_OUTPUT = 396,
    KW_PARAMETER = 397,
    KW_PATHPULSE = 398,
    KW_PMOS = 399,
    KW_POSEDGE = 400,
    KW_PRIMITIVE = 401,
    KW_PULL0 = 402,
    KW_PULL1 = 403,
    KW_PULLDOWN = 404,
    KW_PULLUP = 405,
    KW_PULSESTYLE_ONEVENT = 406,
    KW_PULSESTYLE_ONDETECT = 407,
    KW_RCMOS = 408,
    KW_REAL = 409,
    KW_REALTIME = 410,
    KW_REG = 411,
    KW_RELEASE = 412,
    KW_REPEAT = 413,
    KW_RNMOS = 414,
    KW_RPMOS = 415,
    KW_RTRAN = 416,
    KW_RTRANIF0 = 417,
    KW_RTRANIF1 = 418,
    KW_SCALARED = 419,
    KW_SHOWCANCELLED = 420,
    KW_SIGNED = 421,
    KW_SMALL = 422,
    KW_SPECIFY = 423,
    KW_SPECPARAM = 424,
    KW_STRONG0 = 425,
    KW_STRONG1 = 426,
    KW_SUPPLY0 = 427,
    KW_SUPPLY1 = 428,
    KW_TABLE = 429,
    KW_TASK = 430,
    KW_TIME = 431,
    KW_TRAN = 432,
    KW_TRANIF0 = 433,
    KW_TRANIF1 = 434,
    KW_TRI = 435,
    KW_TRI0 = 436,
    KW_TRI1 = 437,
    KW_TRIAND = 438,
    KW_TRIOR = 439,
    KW_TRIREG = 440,
    KW_UNSIGNED = 441,
    KW_USE = 442,
    KW_VECTORED = 443,
    KW_WAIT = 444,
    KW_WAND = 445,
    KW_WEAK0 = 446,
    KW_WEAK1 = 447,
    KW_WHILE = 448,
    KW_WIRE = 449,
    KW_WOR = 450,
    KW_XNOR = 451,
    KW_XOR = 452
  };
#endif
/* Tokens.  */
#define ANY 258
#define END 259
#define NEWLINE 260
#define SPACE 261
#define TAB 262
#define AT 263
#define COMMA 264
#define HASH 265
#define DOT 266
#define EQ 267
#define COLON 268
#define IDX_PRT_SEL 269
#define SEMICOLON 270
#define OPEN_BRACKET 271
#define CLOSE_BRACKET 272
#define OPEN_SQ_BRACKET 273
#define CLOSE_SQ_BRACKET 274
#define OPEN_SQ_BRACE 275
#define CLOSE_SQ_BRACE 276
#define BIN_VALUE 277
#define OCT_VALUE 278
#define HEX_VALUE 279
#define DEC_BASE 280
#define BIN_BASE 281
#define OCT_BASE 282
#define HEX_BASE 283
#define NUM_REAL 284
#define NUM_SIZE 285
#define UNSIGNED_NUMBER 286
#define SYSTEM_ID 287
#define SIMPLE_ID 288
#define ESCAPED_ID 289
#define DEFINE_ID 290
#define ATTRIBUTE_START 291
#define ATTRIBUTE_END 292
#define COMMENT_LINE 293
#define COMMENT_BLOCK 294
#define MODULE_COMMENT 295
#define STRING 296
#define STAR 297
#define PLUS 298
#define MINUS 299
#define ASL 300
#define ASR 301
#define LSL 302
#define LSR 303
#define DIV 304
#define POW 305
#define MOD 306
#define GTE 307
#define LTE 308
#define GT 309
#define LT 310
#define L_NEG 311
#define L_AND 312
#define L_OR 313
#define C_EQ 314
#define L_EQ 315
#define C_NEQ 316
#define L_NEQ 317
#define B_NEG 318
#define B_AND 319
#define B_OR 320
#define B_XOR 321
#define B_EQU 322
#define B_NAND 323
#define B_NOR 324
#define TERNARY 325
#define UNARY_OP 326
#define MACRO_TEXT 327
#define MACRO_IDENTIFIER 328
#define KW_ALWAYS 329
#define KW_AND 330
#define KW_ASSIGN 331
#define KW_AUTOMATIC 332
#define KW_BEGIN 333
#define KW_BUF 334
#define KW_BUFIF0 335
#define KW_BUFIF1 336
#define KW_CASE 337
#define KW_CASEX 338
#define KW_CASEZ 339
#define KW_CELL 340
#define KW_CMOS 341
#define KW_CONFIG 342
#define KW_DEASSIGN 343
#define KW_DEFAULT 344
#define KW_DEFPARAM 345
#define KW_DESIGN 346
#define KW_DISABLE 347
#define KW_EDGE 348
#define KW_ELSE 349
#define KW_END 350
#define KW_ENDCASE 351
#define KW_ENDCONFIG 352
#define KW_ENDFUNCTION 353
#define KW_ENDGENERATE 354
#define KW_ENDMODULE 355
#define KW_ENDPRIMITIVE 356
#define KW_ENDSPECIFY 357
#define KW_ENDTABLE 358
#define KW_ENDTASK 359
#define KW_EVENT 360
#define KW_FOR 361
#define KW_FORCE 362
#define KW_FOREVER 363
#define KW_FORK 364
#define KW_FUNCTION 365
#define KW_GENERATE 366
#define KW_GENVAR 367
#define KW_HIGHZ0 368
#define KW_HIGHZ1 369
#define KW_IF 370
#define KW_IFNONE 371
#define KW_INCDIR 372
#define KW_INCLUDE 373
#define KW_INITIAL 374
#define KW_INOUT 375
#define KW_INPUT 376
#define KW_INSTANCE 377
#define KW_INTEGER 378
#define KW_JOIN 379
#define KW_LARGE 380
#define KW_LIBLIST 381
#define KW_LIBRARY 382
#define KW_LOCALPARAM 383
#define KW_MACROMODULE 384
#define KW_MEDIUM 385
#define KW_MODULE 386
#define KW_NAND 387
#define KW_NEGEDGE 388
#define KW_NMOS 389
#define KW_NOR 390
#define KW_NOSHOWCANCELLED 391
#define KW_NOT 392
#define KW_NOTIF0 393
#define KW_NOTIF1 394
#define KW_OR 395
#define KW_OUTPUT 396
#define KW_PARAMETER 397
#define KW_PATHPULSE 398
#define KW_PMOS 399
#define KW_POSEDGE 400
#define KW_PRIMITIVE 401
#define KW_PULL0 402
#define KW_PULL1 403
#define KW_PULLDOWN 404
#define KW_PULLUP 405
#define KW_PULSESTYLE_ONEVENT 406
#define KW_PULSESTYLE_ONDETECT 407
#define KW_RCMOS 408
#define KW_REAL 409
#define KW_REALTIME 410
#define KW_REG 411
#define KW_RELEASE 412
#define KW_REPEAT 413
#define KW_RNMOS 414
#define KW_RPMOS 415
#define KW_RTRAN 416
#define KW_RTRANIF0 417
#define KW_RTRANIF1 418
#define KW_SCALARED 419
#define KW_SHOWCANCELLED 420
#define KW_SIGNED 421
#define KW_SMALL 422
#define KW_SPECIFY 423
#define KW_SPECPARAM 424
#define KW_STRONG0 425
#define KW_STRONG1 426
#define KW_SUPPLY0 427
#define KW_SUPPLY1 428
#define KW_TABLE 429
#define KW_TASK 430
#define KW_TIME 431
#define KW_TRAN 432
#define KW_TRANIF0 433
#define KW_TRANIF1 434
#define KW_TRI 435
#define KW_TRI0 436
#define KW_TRI1 437
#define KW_TRIAND 438
#define KW_TRIOR 439
#define KW_TRIREG 440
#define KW_UNSIGNED 441
#define KW_USE 442
#define KW_VECTORED 443
#define KW_WAIT 444
#define KW_WAND 445
#define KW_WEAK0 446
#define KW_WEAK1 447
#define KW_WHILE 448
#define KW_WIRE 449
#define KW_WOR 450
#define KW_XNOR 451
#define KW_XOR 452

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 32 "/home/mason/Desktop/work/verilog-parser/src/verilog_parser.y" /* yacc.c:1909  */

    ast_assignment               * assignment;
    ast_block_item_declaration   * block_item_declaration;
    ast_block_reg_declaration    * block_reg_declaration;
    ast_case_item                * case_item;
    ast_case_statement           * case_statement;
    ast_charge_strength            charge_strength;
    ast_cmos_switch_instance     * cmos_switch_instance ;
    ast_concatenation            * concatenation;
    ast_config_rule_statement    * config_rule_statement;
    ast_config_declaration       * config_declaration;
    ast_library_declaration      * library_declaration;
    ast_library_descriptions     * library_descriptions;
    ast_delay2                   * delay2;
    ast_delay3                   * delay3;
    ast_delay_ctrl               * delay_control;
    ast_delay_value              * delay_value;
    ast_disable_statement        * disable_statement;
    ast_drive_strength           * drive_strength;
    ast_edge                       edge;
    ast_enable_gate_instance     * enable_gate;
    ast_enable_gate_instances    * enable_gates;
    ast_enable_gatetype            enable_gatetype;
    ast_event_control            * event_control;
    ast_event_expression         * event_expression;
    ast_expression               * expression;
    ast_function_call            * call_function;
    ast_function_declaration     * function_declaration;
    ast_function_item_declaration* function_or_task_item;
    ast_gate_instantiation       * gate_instantiation;
    ast_gatetype_n_input           n_input_gatetype;
    ast_generate_block           * generate_block;
    ast_identifier                 identifier;
    ast_if_else                  * ifelse;
    ast_level_symbol               level_symbol;
    ast_list                     * list;
    ast_loop_statement           * loop_statement;
    ast_lvalue                   * lvalue;
    ast_module_declaration       * module_declaration;
    ast_module_instance          * module_instance;
    ast_module_instantiation     * module_instantiation;
    ast_module_item              * module_item;
    ast_mos_switch_instance      * mos_switch_instance  ;
    ast_n_input_gate_instance    * n_input_gate_instance;
    ast_n_input_gate_instances   * n_input_gate_instances;
    ast_n_output_gate_instance   * n_output_gate_instance;
    ast_n_output_gate_instances  * n_output_gate_instances;
    ast_n_output_gatetype          n_output_gatetype;
    ast_net_type                   net_type;
    ast_node                     * node;
    ast_node_attributes          * node_attributes;
    ast_operator                   operator;
    ast_parameter_declarations   * parameter_declaration;
    ast_parameter_type             parameter_type;
    ast_pass_enable_switch       * pass_enable_switch   ;
    ast_pass_enable_switches     * pass_enable_switches;
    ast_pass_switch_instance     * pass_switch_instance ;
    ast_path_declaration         * path_declaration;
    ast_port_connection          * port_connection;
    ast_port_declaration         * port_declaration;
    ast_port_direction             port_direction;
    ast_primary                  * primary;
    ast_primitive_pull_strength  * primitive_pull;
    ast_primitive_strength         primitive_strength;
    ast_pull_gate_instance       * pull_gate_instance   ;
    ast_pulse_control_specparam  * pulse_control_specparam;
    ast_range                    * range;
    ast_range_or_type            * range_or_type;
    ast_single_assignment        * single_assignment;
    ast_source_item              * source_item;
    ast_statement                * generate_item;
    ast_statement                * statement;
    ast_statement_block          * statement_block;
    ast_switch_gate              * switch_gate;
    ast_task_declaration         * task_declaration;
    ast_task_enable_statement    * task_enable_statement;
    ast_task_port                * task_port;
    ast_task_port_type             task_port_type;
    ast_timing_control_statement * timing_control_statement;
    ast_type_declaration         * type_declaration;
    ast_udp_body                 * udp_body;
    ast_udp_combinatorial_entry  * udp_combinatorial_entry;
    ast_udp_declaration          * udp_declaration;
    ast_udp_initial_statement    * udp_initial;
    ast_udp_instance             * udp_instance;
    ast_udp_instantiation        * udp_instantiation;
    ast_udp_next_state             udp_next_state;
    ast_udp_port                 * udp_port;
    ast_udp_sequential_entry     * udp_seqential_entry;
    ast_wait_statement           * wait_statement;
    ast_port_reference           * port_reference;

    char                   boolean;
    char                 * string;
    ast_number           * number;
    char                 * term;
    char                 * keyword;

#line 553 "/home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/verilog_parser.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_HOME_MASON_DESKTOP_WORK_VERILOG_PARSER_CMAKE_BUILD_DEBUG_SRC_VERILOG_PARSER_TAB_H_INCLUDED  */
