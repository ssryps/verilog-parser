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
include src/CMakeFiles/parser.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/parser.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/parser.dir/flags.make

src/CMakeFiles/parser.dir/main.o: src/CMakeFiles/parser.dir/flags.make
src/CMakeFiles/parser.dir/main.o: ../src/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/CMakeFiles/parser.dir/main.o"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/parser.dir/main.o   -c /home/mason/Desktop/work/verilog-parser/src/main.c

src/CMakeFiles/parser.dir/main.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/parser.dir/main.i"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mason/Desktop/work/verilog-parser/src/main.c > CMakeFiles/parser.dir/main.i

src/CMakeFiles/parser.dir/main.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/parser.dir/main.s"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mason/Desktop/work/verilog-parser/src/main.c -o CMakeFiles/parser.dir/main.s

# Object files for target parser
parser_OBJECTS = \
"CMakeFiles/parser.dir/main.o"

# External object files for target parser
parser_EXTERNAL_OBJECTS =

src/parser: src/CMakeFiles/parser.dir/main.o
src/parser: src/CMakeFiles/parser.dir/build.make
src/parser: src/libverilogparser.a
src/parser: src/CMakeFiles/parser.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable parser"
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/parser.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/parser.dir/build: src/parser

.PHONY : src/CMakeFiles/parser.dir/build

src/CMakeFiles/parser.dir/clean:
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src && $(CMAKE_COMMAND) -P CMakeFiles/parser.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/parser.dir/clean

src/CMakeFiles/parser.dir/depend:
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mason/Desktop/work/verilog-parser /home/mason/Desktop/work/verilog-parser/src /home/mason/Desktop/work/verilog-parser/cmake-build-debug /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src /home/mason/Desktop/work/verilog-parser/cmake-build-debug/src/CMakeFiles/parser.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/parser.dir/depend

