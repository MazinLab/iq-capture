-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2020.1.1
-- Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adc_capture_pair_iq is
port (
    ap_ready : OUT STD_LOGIC;
    i_in : IN STD_LOGIC_VECTOR (127 downto 0);
    q_in : IN STD_LOGIC_VECTOR (127 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (255 downto 0) );
end;


architecture behav of adc_capture_pair_iq is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_10 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010000";
    constant ap_const_lv32_1F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011111";
    constant ap_const_lv32_20 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000100000";
    constant ap_const_lv32_2F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000101111";
    constant ap_const_lv32_30 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000110000";
    constant ap_const_lv32_3F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000111111";
    constant ap_const_lv32_40 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001000000";
    constant ap_const_lv32_4F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001001111";
    constant ap_const_lv32_50 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001010000";
    constant ap_const_lv32_5F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001011111";
    constant ap_const_lv32_60 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001100000";
    constant ap_const_lv32_6F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001101111";
    constant ap_const_lv32_70 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001110000";
    constant ap_const_lv32_7F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000001111111";
    constant ap_const_logic_0 : STD_LOGIC := '0';

attribute shreg_extract : string;
    signal p_Result_2_7_fu_196_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_7_fu_186_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_2_6_fu_176_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_6_fu_166_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_2_5_fu_156_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_5_fu_146_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_2_4_fu_136_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_4_fu_126_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_2_3_fu_116_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_3_fu_106_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_2_2_fu_96_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_s_fu_86_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_2_1_fu_76_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_1_fu_66_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_1_fu_62_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_fu_58_p1 : STD_LOGIC_VECTOR (15 downto 0);


begin



    ap_ready <= ap_const_logic_1;
    ap_return <= (((((((((((((((p_Result_2_7_fu_196_p4 & p_Result_7_fu_186_p4) & p_Result_2_6_fu_176_p4) & p_Result_6_fu_166_p4) & p_Result_2_5_fu_156_p4) & p_Result_5_fu_146_p4) & p_Result_2_4_fu_136_p4) & p_Result_4_fu_126_p4) & p_Result_2_3_fu_116_p4) & p_Result_3_fu_106_p4) & p_Result_2_2_fu_96_p4) & p_Result_s_fu_86_p4) & p_Result_2_1_fu_76_p4) & p_Result_1_fu_66_p4) & trunc_ln674_1_fu_62_p1) & trunc_ln674_fu_58_p1);
    p_Result_1_fu_66_p4 <= i_in(31 downto 16);
    p_Result_2_1_fu_76_p4 <= q_in(31 downto 16);
    p_Result_2_2_fu_96_p4 <= q_in(47 downto 32);
    p_Result_2_3_fu_116_p4 <= q_in(63 downto 48);
    p_Result_2_4_fu_136_p4 <= q_in(79 downto 64);
    p_Result_2_5_fu_156_p4 <= q_in(95 downto 80);
    p_Result_2_6_fu_176_p4 <= q_in(111 downto 96);
    p_Result_2_7_fu_196_p4 <= q_in(127 downto 112);
    p_Result_3_fu_106_p4 <= i_in(63 downto 48);
    p_Result_4_fu_126_p4 <= i_in(79 downto 64);
    p_Result_5_fu_146_p4 <= i_in(95 downto 80);
    p_Result_6_fu_166_p4 <= i_in(111 downto 96);
    p_Result_7_fu_186_p4 <= i_in(127 downto 112);
    p_Result_s_fu_86_p4 <= i_in(47 downto 32);
    trunc_ln674_1_fu_62_p1 <= q_in(16 - 1 downto 0);
    trunc_ln674_fu_58_p1 <= i_in(16 - 1 downto 0);
end behav;