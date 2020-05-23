#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/media/mason/DATA/cstools/IDE/vivado/SDK/2018.1/bin:/media/mason/DATA/cstools/IDE/vivado/Vivado/2018.1/ids_lite/ISE/bin/lin64:/media/mason/DATA/cstools/IDE/vivado/Vivado/2018.1/bin
else
  PATH=/media/mason/DATA/cstools/IDE/vivado/SDK/2018.1/bin:/media/mason/DATA/cstools/IDE/vivado/Vivado/2018.1/ids_lite/ISE/bin/lin64:/media/mason/DATA/cstools/IDE/vivado/Vivado/2018.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/media/mason/DATA/cstools/IDE/vivado/Vivado/2018.1/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/media/mason/DATA/cstools/IDE/vivado/Vivado/2018.1/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/mason/Desktop/work/verilog-parser/tests/cod19grp7/Uncommented_old_version/Uncommented_old_version.runs/blk_mem_ascii_rom_synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log blk_mem_ascii_rom.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source blk_mem_ascii_rom.tcl
