# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /media/mason/DATA/cstools/IDE/clion-2019.2.4/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /media/mason/DATA/cstools/IDE/clion-2019.2.4/bin/cmake/linux/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/mason/Desktop/work/verilog-parser

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/mason/Desktop/work/verilog-parser/cmake-build-debug

# Include any dependencies generated for this target.
include src/CMakeFiles/verilogparser.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/verilogparser.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/verilogparser.dir/flags.make

src/verilog_scanner.c: src/verilog_parser.tab.c
src/verilog_scanner.c: ../src/verilog_scanner.l
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating verilog_scanner.c"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/flex -o /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/verilog_scanner.c /home/mason/Desktop/work/verilog-parser/src/verilog_scanner.l

src/verilog_parser.tab.c: ../src/verilog_parser.y
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating verilog_parser.tab.c"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/bison -y /home/mason/Desktop/work/verilog-parser/src/verilog_parser.y -o /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/verilog_parser.tab.c

src/CMakeFiles/verilogparser.dir/verilog_scanner.o: src/CMakeFiles/verilogparser.dir/flags.make
src/CMakeFiles/verilogparser.dir/verilog_scanner.o: src/verilog_scanner.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object src/CMakeFiles/verilogparser.dir/verilog_scanner.o"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/verilogparser.dir/verilog_scanner.o   -c /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/verilog_scanner.c

src/CMakeFiles/verilogparser.dir/verilog_scanner.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/verilogparser.dir/verilog_scanner.i"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/verilog_scanner.c > CMakeFiles/verilogparser.dir/verilog_scanner.i

src/CMakeFiles/verilogparser.dir/verilog_scanner.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/verilogparser.dir/verilog_scanner.s"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/verilog_scanner.c -o CMakeFiles/verilogparser.dir/verilog_scanner.s

src/CMakeFiles/verilogparser.dir/verilog_parser.tab.o: src/CMakeFiles/verilogparser.dir/flags.make
src/CMakeFiles/verilogparser.dir/verilog_parser.tab.o: src/verilog_parser.tab.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object src/CMakeFiles/verilogparser.dir/verilog_parser.tab.o"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/verilogparser.dir/verilog_parser.tab.o   -c /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/verilog_parser.tab.c

src/CMakeFiles/verilogparser.dir/verilog_parser.tab.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/verilogparser.dir/verilog_parser.tab.i"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/verilog_parser.tab.c > CMakeFiles/verilogparser.dir/verilog_parser.tab.i

src/CMakeFiles/verilogparser.dir/verilog_parser.tab.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/verilogparser.dir/verilog_parser.tab.s"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/verilog_parser.tab.c -o CMakeFiles/verilogparser.dir/verilog_parser.tab.s

src/CMakeFiles/verilogparser.dir/verilog_ast.o: src/CMakeFiles/verilogparser.dir/flags.make
src/CMakeFiles/verilogparser.dir/verilog_ast.o: ../src/verilog_ast.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object src/CMakeFiles/verilogparser.dir/verilog_ast.o"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/verilogparser.dir/verilog_ast.o   -c /home/mason/Desktop/work/verilog-parser/src/verilog_ast.c

src/CMakeFiles/verilogparser.dir/verilog_ast.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/verilogparser.dir/verilog_ast.i"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mason/Desktop/work/verilog-parser/src/verilog_ast.c > CMakeFiles/verilogparser.dir/verilog_ast.i

src/CMakeFiles/verilogparser.dir/verilog_ast.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/verilogparser.dir/verilog_ast.s"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mason/Desktop/work/verilog-parser/src/verilog_ast.c -o CMakeFiles/verilogparser.dir/verilog_ast.s

src/CMakeFiles/verilogparser.dir/verilog_ast_mem.o: src/CMakeFiles/verilogparser.dir/flags.make
src/CMakeFiles/verilogparser.dir/verilog_ast_mem.o: ../src/verilog_ast_mem.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object src/CMakeFiles/verilogparser.dir/verilog_ast_mem.o"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/verilogparser.dir/verilog_ast_mem.o   -c /home/mason/Desktop/work/verilog-parser/src/verilog_ast_mem.c

src/CMakeFiles/verilogparser.dir/verilog_ast_mem.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/verilogparser.dir/verilog_ast_mem.i"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mason/Desktop/work/verilog-parser/src/verilog_ast_mem.c > CMakeFiles/verilogparser.dir/verilog_ast_mem.i

src/CMakeFiles/verilogparser.dir/verilog_ast_mem.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/verilogparser.dir/verilog_ast_mem.s"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mason/Desktop/work/verilog-parser/src/verilog_ast_mem.c -o CMakeFiles/verilogparser.dir/verilog_ast_mem.s

src/CMakeFiles/verilogparser.dir/verilog_ast_util.o: src/CMakeFiles/verilogparser.dir/flags.make
src/CMakeFiles/verilogparser.dir/verilog_ast_util.o: ../src/verilog_ast_util.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object src/CMakeFiles/verilogparser.dir/verilog_ast_util.o"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/verilogparser.dir/verilog_ast_util.o   -c /home/mason/Desktop/work/verilog-parser/src/verilog_ast_util.c

src/CMakeFiles/verilogparser.dir/verilog_ast_util.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/verilogparser.dir/verilog_ast_util.i"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mason/Desktop/work/verilog-parser/src/verilog_ast_util.c > CMakeFiles/verilogparser.dir/verilog_ast_util.i

src/CMakeFiles/verilogparser.dir/verilog_ast_util.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/verilogparser.dir/verilog_ast_util.s"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mason/Desktop/work/verilog-parser/src/verilog_ast_util.c -o CMakeFiles/verilogparser.dir/verilog_ast_util.s

src/CMakeFiles/verilogparser.dir/verilog_ast_common.o: src/CMakeFiles/verilogparser.dir/flags.make
src/CMakeFiles/verilogparser.dir/verilog_ast_common.o: ../src/verilog_ast_common.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building C object src/CMakeFiles/verilogparser.dir/verilog_ast_common.o"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/verilogparser.dir/verilog_ast_common.o   -c /home/mason/Desktop/work/verilog-parser/src/verilog_ast_common.c

src/CMakeFiles/verilogparser.dir/verilog_ast_common.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/verilogparser.dir/verilog_ast_common.i"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mason/Desktop/work/verilog-parser/src/verilog_ast_common.c > CMakeFiles/verilogparser.dir/verilog_ast_common.i

src/CMakeFiles/verilogparser.dir/verilog_ast_common.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/verilogparser.dir/verilog_ast_common.s"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mason/Desktop/work/verilog-parser/src/verilog_ast_common.c -o CMakeFiles/verilogparser.dir/verilog_ast_common.s

src/CMakeFiles/verilogparser.dir/verilog_parser_wrapper.o: src/CMakeFiles/verilogparser.dir/flags.make
src/CMakeFiles/verilogparser.dir/verilog_parser_wrapper.o: ../src/verilog_parser_wrapper.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building C object src/CMakeFiles/verilogparser.dir/verilog_parser_wrapper.o"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/verilogparser.dir/verilog_parser_wrapper.o   -c /home/mason/Desktop/work/verilog-parser/src/verilog_parser_wrapper.c

src/CMakeFiles/verilogparser.dir/verilog_parser_wrapper.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/verilogparser.dir/verilog_parser_wrapper.i"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mason/Desktop/work/verilog-parser/src/verilog_parser_wrapper.c > CMakeFiles/verilogparser.dir/verilog_parser_wrapper.i

src/CMakeFiles/verilogparser.dir/verilog_parser_wrapper.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/verilogparser.dir/verilog_parser_wrapper.s"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mason/Desktop/work/verilog-parser/src/verilog_parser_wrapper.c -o CMakeFiles/verilogparser.dir/verilog_parser_wrapper.s

src/CMakeFiles/verilogparser.dir/verilog_preprocessor.o: src/CMakeFiles/verilogparser.dir/flags.make
src/CMakeFiles/verilogparser.dir/verilog_preprocessor.o: ../src/verilog_preprocessor.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building C object src/CMakeFiles/verilogparser.dir/verilog_preprocessor.o"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/verilogparser.dir/verilog_preprocessor.o   -c /home/mason/Desktop/work/verilog-parser/src/verilog_preprocessor.c

src/CMakeFiles/verilogparser.dir/verilog_preprocessor.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/verilogparser.dir/verilog_preprocessor.i"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mason/Desktop/work/verilog-parser/src/verilog_preprocessor.c > CMakeFiles/verilogparser.dir/verilog_preprocessor.i

src/CMakeFiles/verilogparser.dir/verilog_preprocessor.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/verilogparser.dir/verilog_preprocessor.s"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mason/Desktop/work/verilog-parser/src/verilog_preprocessor.c -o CMakeFiles/verilogparser.dir/verilog_preprocessor.s

src/CMakeFiles/verilogparser.dir/verilog_cmd_parser.o: src/CMakeFiles/verilogparser.dir/flags.make
src/CMakeFiles/verilogparser.dir/verilog_cmd_parser.o: ../src/verilog_cmd_parser.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Building C object src/CMakeFiles/verilogparser.dir/verilog_cmd_parser.o"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/verilogparser.dir/verilog_cmd_parser.o   -c /home/mason/Desktop/work/verilog-parser/src/verilog_cmd_parser.c

src/CMakeFiles/verilogparser.dir/verilog_cmd_parser.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/verilogparser.dir/verilog_cmd_parser.i"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mason/Desktop/work/verilog-parser/src/verilog_cmd_parser.c > CMakeFiles/verilogparser.dir/verilog_cmd_parser.i

src/CMakeFiles/verilogparser.dir/verilog_cmd_parser.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/verilogparser.dir/verilog_cmd_parser.s"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mason/Desktop/work/verilog-parser/src/verilog_cmd_parser.c -o CMakeFiles/verilogparser.dir/verilog_cmd_parser.s

# Object files for target verilogparser
verilogparser_OBJECTS = \
"CMakeFiles/verilogparser.dir/verilog_scanner.o" \
"CMakeFiles/verilogparser.dir/verilog_parser.tab.o" \
"CMakeFiles/verilogparser.dir/verilog_ast.o" \
"CMakeFiles/verilogparser.dir/verilog_ast_mem.o" \
"CMakeFiles/verilogparser.dir/verilog_ast_util.o" \
"CMakeFiles/verilogparser.dir/verilog_ast_common.o" \
"CMakeFiles/verilogparser.dir/verilog_parser_wrapper.o" \
"CMakeFiles/verilogparser.dir/verilog_preprocessor.o" \
"CMakeFiles/verilogparser.dir/verilog_cmd_parser.o"

# External object files for target verilogparser
verilogparser_EXTERNAL_OBJECTS =

src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/verilog_scanner.o
src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/verilog_parser.tab.o
src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/verilog_ast.o
src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/verilog_ast_mem.o
src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/verilog_ast_util.o
src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/verilog_ast_common.o
src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/verilog_parser_wrapper.o
src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/verilog_preprocessor.o
src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/verilog_cmd_parser.o
src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/build.make
src/libverilogparser.a: src/CMakeFiles/verilogparser.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_12) "Linking C static library libverilogparser.a"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && $(CMAKE_COMMAND) -P CMakeFiles/verilogparser.dir/cmake_clean_target.cmake
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/verilogparser.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/verilogparser.dir/build: src/libverilogparser.a

.PHONY : src/CMakeFiles/verilogparser.dir/build

src/CMakeFiles/verilogparser.dir/clean:
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && $(CMAKE_COMMAND) -P CMakeFiles/verilogparser.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/verilogparser.dir/clean

src/CMakeFiles/verilogparser.dir/depend: src/verilog_scanner.c
src/CMakeFiles/verilogparser.dir/depend: src/verilog_parser.tab.c
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mason/Desktop/work/verilog-parser /home/mason/Desktop/work/verilog-parser/src /home/mason/Desktop/work/verilog-parser/cmake-build-debug /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/CMakeFiles/verilogparser.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/verilogparser.dir/depend

