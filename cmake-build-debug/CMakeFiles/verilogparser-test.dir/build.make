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

# Utility rule file for verilogparser-test.

# Include the progress variables for this target.
include CMakeFiles/verilogparser-test.dir/progress.make

CMakeFiles/verilogparser-test:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Running Test Suite"
	cd /home/mason/Desktop/work/verilog-parser && ./bin/run-tests.sh

verilogparser-test: CMakeFiles/verilogparser-test
verilogparser-test: CMakeFiles/verilogparser-test.dir/build.make

.PHONY : verilogparser-test

# Rule to build all files generated by this target.
CMakeFiles/verilogparser-test.dir/build: verilogparser-test

.PHONY : CMakeFiles/verilogparser-test.dir/build

CMakeFiles/verilogparser-test.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/verilogparser-test.dir/cmake_clean.cmake
.PHONY : CMakeFiles/verilogparser-test.dir/clean

CMakeFiles/verilogparser-test.dir/depend:
	cd /home/mason/Desktop/work/verilog-parser/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mason/Desktop/work/verilog-parser /home/mason/Desktop/work/verilog-parser /home/mason/Desktop/work/verilog-parser/cmake-build-debug /home/mason/Desktop/work/verilog-parser/cmake-build-debug /home/mason/Desktop/work/verilog-parser/cmake-build-debug/CMakeFiles/verilogparser-test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/verilogparser-test.dir/depend

