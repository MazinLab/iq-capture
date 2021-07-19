-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity iq_capture_capture_data_ap_uint_256_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    fetched16_dout : IN STD_LOGIC_VECTOR (255 downto 0);
    fetched16_empty_n : IN STD_LOGIC;
    fetched16_read : OUT STD_LOGIC;
    fetched_keep18_dout : IN STD_LOGIC_VECTOR (0 downto 0);
    fetched_keep18_empty_n : IN STD_LOGIC;
    fetched_keep18_read : OUT STD_LOGIC;
    capturesize : IN STD_LOGIC_VECTOR (34 downto 0);
    toout17_din : OUT STD_LOGIC_VECTOR (255 downto 0);
    toout17_full_n : IN STD_LOGIC;
    toout17_write : OUT STD_LOGIC );
end;


architecture behav of iq_capture_capture_data_ap_uint_256_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (4 downto 0) := "00010";
    constant ap_ST_fsm_pp0_stage1 : STD_LOGIC_VECTOR (4 downto 0) := "00100";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (4 downto 0) := "01000";
    constant ap_ST_fsm_state7 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv36_FFFFFFFFF : STD_LOGIC_VECTOR (35 downto 0) := "111111111111111111111111111111111111";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal fetched16_blk_n : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage1 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal ap_block_pp0_stage1 : BOOLEAN;
    signal icmp_ln1057_reg_123 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal fetched_keep18_blk_n : STD_LOGIC;
    signal toout17_blk_n : STD_LOGIC;
    signal tmp_reg_132 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_7_reg_136 : STD_LOGIC_VECTOR (0 downto 0);
    signal reg_69 : STD_LOGIC_VECTOR (255 downto 0);
    signal ap_block_state3_pp0_stage1_iter0 : BOOLEAN;
    signal ap_block_state5_pp0_stage1_iter1 : BOOLEAN;
    signal ap_block_pp0_stage1_11001 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal sub_i_i_fu_78_p2 : STD_LOGIC_VECTOR (35 downto 0);
    signal icmp_ln1057_fu_96_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_fu_101_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_reg_127 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_state1 : BOOLEAN;
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_condition_pp0_exit_iter0_state2 : STD_LOGIC;
    signal ap_block_pp0_stage1_subdone : BOOLEAN;
    signal i_2_fu_40 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal ap_block_pp0_stage1_01001 : BOOLEAN;
    signal capturesize_cast_fu_74_p1 : STD_LOGIC_VECTOR (35 downto 0);
    signal sext_ln1057_fu_92_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal sext_ln1057_fu_92_p1 : STD_LOGIC_VECTOR (35 downto 0);
    signal i_fu_101_p0 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_CS_fsm_state7 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state7 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state6_blk : STD_LOGIC;
    signal ap_ST_fsm_state7_blk : STD_LOGIC;
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;


begin




    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_condition_pp0_exit_iter0_state2))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
                elsif ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage1_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
                    ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                elsif ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i_2_fu_40_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                i_2_fu_40 <= ap_const_lv32_0;
            elsif (((icmp_ln1057_reg_123 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
                i_2_fu_40 <= i_reg_127;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (icmp_ln1057_fu_96_p2 = ap_const_lv1_1))) then
                i_reg_127 <= i_fu_101_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln1057_reg_123 <= icmp_ln1057_fu_96_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((icmp_ln1057_reg_123 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)))) then
                reg_69 <= fetched16_dout;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp_7_reg_136 <= fetched_keep18_dout;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln1057_reg_123 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then
                tmp_reg_132 <= fetched_keep18_dout;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, icmp_ln1057_fu_96_p2, ap_block_pp0_stage0_subdone, ap_block_pp0_stage1_subdone)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_pp0_stage0 => 
                if ((not(((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (icmp_ln1057_fu_96_p2 = ap_const_lv1_0))) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                elsif (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (icmp_ln1057_fu_96_p2 = ap_const_lv1_0))) then
                    ap_NS_fsm <= ap_ST_fsm_state6;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_pp0_stage1 => 
                if ((not(((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then
                    ap_NS_fsm <= ap_ST_fsm_state6;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                end if;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when ap_ST_fsm_state7 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXXX";
        end case;
    end process;
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(1);
    ap_CS_fsm_pp0_stage1 <= ap_CS_fsm(2);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state7 <= ap_CS_fsm(4);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start, ap_done_reg)
    begin
        if (((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state6_blk <= ap_const_logic_0;
    ap_ST_fsm_state7_blk <= ap_const_logic_0;
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(fetched16_empty_n, fetched_keep18_empty_n, toout17_full_n, ap_enable_reg_pp0_iter1, tmp_reg_132)
    begin
                ap_block_pp0_stage0_01001 <= ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and ((fetched_keep18_empty_n = ap_const_logic_0) or (fetched16_empty_n = ap_const_logic_0) or ((tmp_reg_132 = ap_const_lv1_1) and (toout17_full_n = ap_const_logic_0))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(fetched16_empty_n, fetched_keep18_empty_n, toout17_full_n, ap_enable_reg_pp0_iter1, tmp_reg_132)
    begin
                ap_block_pp0_stage0_11001 <= ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and ((fetched_keep18_empty_n = ap_const_logic_0) or (fetched16_empty_n = ap_const_logic_0) or ((tmp_reg_132 = ap_const_lv1_1) and (toout17_full_n = ap_const_logic_0))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(fetched16_empty_n, fetched_keep18_empty_n, toout17_full_n, ap_enable_reg_pp0_iter1, tmp_reg_132)
    begin
                ap_block_pp0_stage0_subdone <= ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and ((fetched_keep18_empty_n = ap_const_logic_0) or (fetched16_empty_n = ap_const_logic_0) or ((tmp_reg_132 = ap_const_lv1_1) and (toout17_full_n = ap_const_logic_0))));
    end process;

        ap_block_pp0_stage1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage1_01001_assign_proc : process(fetched16_empty_n, fetched_keep18_empty_n, toout17_full_n, ap_enable_reg_pp0_iter0, icmp_ln1057_reg_123, ap_enable_reg_pp0_iter1, tmp_7_reg_136)
    begin
                ap_block_pp0_stage1_01001 <= (((tmp_7_reg_136 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (toout17_full_n = ap_const_logic_0)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln1057_reg_123 = ap_const_lv1_1) and (fetched_keep18_empty_n = ap_const_logic_0)) or ((icmp_ln1057_reg_123 = ap_const_lv1_1) and (fetched16_empty_n = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage1_11001_assign_proc : process(fetched16_empty_n, fetched_keep18_empty_n, toout17_full_n, ap_enable_reg_pp0_iter0, icmp_ln1057_reg_123, ap_enable_reg_pp0_iter1, tmp_7_reg_136)
    begin
                ap_block_pp0_stage1_11001 <= (((tmp_7_reg_136 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (toout17_full_n = ap_const_logic_0)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln1057_reg_123 = ap_const_lv1_1) and (fetched_keep18_empty_n = ap_const_logic_0)) or ((icmp_ln1057_reg_123 = ap_const_lv1_1) and (fetched16_empty_n = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage1_subdone_assign_proc : process(fetched16_empty_n, fetched_keep18_empty_n, toout17_full_n, ap_enable_reg_pp0_iter0, icmp_ln1057_reg_123, ap_enable_reg_pp0_iter1, tmp_7_reg_136)
    begin
                ap_block_pp0_stage1_subdone <= (((tmp_7_reg_136 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (toout17_full_n = ap_const_logic_0)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln1057_reg_123 = ap_const_lv1_1) and (fetched_keep18_empty_n = ap_const_logic_0)) or ((icmp_ln1057_reg_123 = ap_const_lv1_1) and (fetched16_empty_n = ap_const_logic_0)))));
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg)
    begin
                ap_block_state1 <= ((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0));
    end process;

        ap_block_state2_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state3_pp0_stage1_iter0_assign_proc : process(fetched16_empty_n, fetched_keep18_empty_n, icmp_ln1057_reg_123)
    begin
                ap_block_state3_pp0_stage1_iter0 <= (((icmp_ln1057_reg_123 = ap_const_lv1_1) and (fetched_keep18_empty_n = ap_const_logic_0)) or ((icmp_ln1057_reg_123 = ap_const_lv1_1) and (fetched16_empty_n = ap_const_logic_0)));
    end process;


    ap_block_state4_pp0_stage0_iter1_assign_proc : process(fetched16_empty_n, fetched_keep18_empty_n, toout17_full_n, tmp_reg_132)
    begin
                ap_block_state4_pp0_stage0_iter1 <= ((fetched_keep18_empty_n = ap_const_logic_0) or (fetched16_empty_n = ap_const_logic_0) or ((tmp_reg_132 = ap_const_lv1_1) and (toout17_full_n = ap_const_logic_0)));
    end process;


    ap_block_state5_pp0_stage1_iter1_assign_proc : process(toout17_full_n, tmp_7_reg_136)
    begin
                ap_block_state5_pp0_stage1_iter1 <= ((tmp_7_reg_136 = ap_const_lv1_1) and (toout17_full_n = ap_const_logic_0));
    end process;


    ap_condition_pp0_exit_iter0_state2_assign_proc : process(icmp_ln1057_fu_96_p2)
    begin
        if ((icmp_ln1057_fu_96_p2 = ap_const_lv1_0)) then 
            ap_condition_pp0_exit_iter0_state2 <= ap_const_logic_1;
        else 
            ap_condition_pp0_exit_iter0_state2 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state7)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state7)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    capturesize_cast_fu_74_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(capturesize),36));

    fetched16_blk_n_assign_proc : process(fetched16_empty_n, ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter0, ap_block_pp0_stage1, icmp_ln1057_reg_123, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0)
    begin
        if ((((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((icmp_ln1057_reg_123 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)))) then 
            fetched16_blk_n <= fetched16_empty_n;
        else 
            fetched16_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    fetched16_read_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter0, icmp_ln1057_reg_123, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage1_11001, ap_block_pp0_stage0_11001)
    begin
        if ((((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((icmp_ln1057_reg_123 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)))) then 
            fetched16_read <= ap_const_logic_1;
        else 
            fetched16_read <= ap_const_logic_0;
        end if; 
    end process;


    fetched_keep18_blk_n_assign_proc : process(fetched_keep18_empty_n, ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter0, ap_block_pp0_stage1, icmp_ln1057_reg_123, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0)
    begin
        if ((((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((icmp_ln1057_reg_123 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)))) then 
            fetched_keep18_blk_n <= fetched_keep18_empty_n;
        else 
            fetched_keep18_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    fetched_keep18_read_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_enable_reg_pp0_iter0, icmp_ln1057_reg_123, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage1_11001, ap_block_pp0_stage0_11001)
    begin
        if ((((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((icmp_ln1057_reg_123 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)))) then 
            fetched_keep18_read <= ap_const_logic_1;
        else 
            fetched_keep18_read <= ap_const_logic_0;
        end if; 
    end process;

    i_fu_101_p0 <= i_2_fu_40;
    i_fu_101_p2 <= std_logic_vector(signed(i_fu_101_p0) + signed(ap_const_lv32_2));
    icmp_ln1057_fu_96_p2 <= "1" when (signed(sext_ln1057_fu_92_p1) < signed(sub_i_i_fu_78_p2)) else "0";
    sext_ln1057_fu_92_p0 <= i_2_fu_40;
        sext_ln1057_fu_92_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(sext_ln1057_fu_92_p0),36));

    sub_i_i_fu_78_p2 <= std_logic_vector(unsigned(capturesize_cast_fu_74_p1) + unsigned(ap_const_lv36_FFFFFFFFF));

    toout17_blk_n_assign_proc : process(toout17_full_n, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage1, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0, tmp_reg_132, tmp_7_reg_136)
    begin
        if ((((tmp_7_reg_136 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((tmp_reg_132 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            toout17_blk_n <= toout17_full_n;
        else 
            toout17_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    toout17_din <= reg_69;

    toout17_write_assign_proc : process(ap_CS_fsm_pp0_stage1, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, tmp_reg_132, tmp_7_reg_136, ap_block_pp0_stage1_11001, ap_block_pp0_stage0_11001)
    begin
        if ((((tmp_7_reg_136 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((tmp_reg_132 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            toout17_write <= ap_const_logic_1;
        else 
            toout17_write <= ap_const_logic_0;
        end if; 
    end process;

end behav;
