-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
-- Date        : Sat May 23 13:57:53 2020
-- Host        : dell running 64-bit Ubuntu 18.04.3 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/mason/Desktop/work/verilog-parser/tests/cod19grp9/Uncommented_old_verison/Uncommented_old_verison.srcs/sources_1/ip/pll_example/pll_example_stub.vhdl
-- Design      : pll_example
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tfgg676-2L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pll_example is
  Port ( 
    clk_out1 : out STD_LOGIC;
    clk_out2 : out STD_LOGIC;
    clk_out2_noshift : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end pll_example;

architecture stub of pll_example is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,clk_out2,clk_out2_noshift,reset,locked,clk_in1";
begin
end;
