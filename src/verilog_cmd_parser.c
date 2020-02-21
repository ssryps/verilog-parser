/*!
@file verilog-dot.cpp
@brief Contains common data structures and functions used by the program
*/

#include "verilog_cmd_parser.h"

const char KPathSeparator =
#ifdef _WIN32
        '\\';
#else
        '/';
#endif

