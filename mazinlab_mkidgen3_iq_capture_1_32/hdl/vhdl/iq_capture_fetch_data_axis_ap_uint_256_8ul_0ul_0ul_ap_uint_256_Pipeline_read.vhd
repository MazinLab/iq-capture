-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity iq_capture_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    capturesize : IN STD_LOGIC_VECTOR (34 downto 0);
    resstream_TDATA : IN STD_LOGIC_VECTOR (255 downto 0);
    resstream_TVALID : IN STD_LOGIC;
    resstream_TREADY : OUT STD_LOGIC;
    resstream_TKEEP : IN STD_LOGIC_VECTOR (31 downto 0);
    resstream_TSTRB : IN STD_LOGIC_VECTOR (31 downto 0);
    resstream_TUSER : IN STD_LOGIC_VECTOR (7 downto 0);
    resstream_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
    fetched16_din : OUT STD_LOGIC_VECTOR (255 downto 0);
    fetched16_full_n : IN STD_LOGIC;
    fetched16_write : OUT STD_LOGIC;
    keep : IN STD_LOGIC_VECTOR (255 downto 0);
    fetched_keep18_din : OUT STD_LOGIC_VECTOR (0 downto 0);
    fetched_keep18_full_n : IN STD_LOGIC;
    fetched_keep18_write : OUT STD_LOGIC );
end;


architecture behav of iq_capture_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (4 downto 0) := "00010";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (4 downto 0) := "00100";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (4 downto 0) := "01000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv35_0 : STD_LOGIC_VECTOR (34 downto 0) := "00000000000000000000000000000000000";
    constant ap_const_lv35_1 : STD_LOGIC_VECTOR (34 downto 0) := "00000000000000000000000000000000001";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal keep_0_data_reg : STD_LOGIC_VECTOR (255 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    signal keep_0_vld_reg : STD_LOGIC := '0';
    signal keep_0_ack_out : STD_LOGIC;
    signal resstream_TDATA_blk_n : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal icmp_ln30_fu_108_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal fetched16_blk_n : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal fetched_keep18_blk_n : STD_LOGIC;
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal resin_reg_159 : STD_LOGIC_VECTOR (255 downto 0);
    signal ap_block_state3_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal p_Result_s_fu_127_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_s_reg_164 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_condition_pp0_exit_iter0_state3 : STD_LOGIC;
    signal i_fu_56 : STD_LOGIC_VECTOR (34 downto 0);
    signal add_ln1057_fu_113_p2 : STD_LOGIC_VECTOR (34 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal ap_CS_fsm_state6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state6 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state5_blk : STD_LOGIC;
    signal ap_ST_fsm_state6_blk : STD_LOGIC;
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal regslice_both_resstream_V_data_V_U_apdone_blk : STD_LOGIC;
    signal resstream_TDATA_int_regslice : STD_LOGIC_VECTOR (255 downto 0);
    signal resstream_TVALID_int_regslice : STD_LOGIC;
    signal resstream_TREADY_int_regslice : STD_LOGIC;
    signal regslice_both_resstream_V_data_V_U_ack_in : STD_LOGIC;
    signal regslice_both_resstream_V_keep_V_U_apdone_blk : STD_LOGIC;
    signal resstream_TKEEP_int_regslice : STD_LOGIC_VECTOR (31 downto 0);
    signal regslice_both_resstream_V_keep_V_U_vld_out : STD_LOGIC;
    signal regslice_both_resstream_V_keep_V_U_ack_in : STD_LOGIC;
    signal regslice_both_resstream_V_strb_V_U_apdone_blk : STD_LOGIC;
    signal resstream_TSTRB_int_regslice : STD_LOGIC_VECTOR (31 downto 0);
    signal regslice_both_resstream_V_strb_V_U_vld_out : STD_LOGIC;
    signal regslice_both_resstream_V_strb_V_U_ack_in : STD_LOGIC;
    signal regslice_both_resstream_V_user_V_U_apdone_blk : STD_LOGIC;
    signal resstream_TUSER_int_regslice : STD_LOGIC_VECTOR (7 downto 0);
    signal regslice_both_resstream_V_user_V_U_vld_out : STD_LOGIC;
    signal regslice_both_resstream_V_user_V_U_ack_in : STD_LOGIC;
    signal regslice_both_resstream_V_last_V_U_apdone_blk : STD_LOGIC;
    signal resstream_TLAST_int_regslice : STD_LOGIC_VECTOR (0 downto 0);
    signal regslice_both_resstream_V_last_V_U_vld_out : STD_LOGIC;
    signal regslice_both_resstream_V_last_V_U_ack_in : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component iq_capture_regslice_both IS
    generic (
        DataWidth : INTEGER );
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR (DataWidth-1 downto 0);
        vld_in : IN STD_LOGIC;
        ack_in : OUT STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR (DataWidth-1 downto 0);
        vld_out : OUT STD_LOGIC;
        ack_out : IN STD_LOGIC;
        apdone_blk : OUT STD_LOGIC );
    end component;



begin
    regslice_both_resstream_V_data_V_U : component iq_capture_regslice_both
    generic map (
        DataWidth => 256)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => resstream_TDATA,
        vld_in => resstream_TVALID,
        ack_in => regslice_both_resstream_V_data_V_U_ack_in,
        data_out => resstream_TDATA_int_regslice,
        vld_out => resstream_TVALID_int_regslice,
        ack_out => resstream_TREADY_int_regslice,
        apdone_blk => regslice_both_resstream_V_data_V_U_apdone_blk);

    regslice_both_resstream_V_keep_V_U : component iq_capture_regslice_both
    generic map (
        DataWidth => 32)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => resstream_TKEEP,
        vld_in => resstream_TVALID,
        ack_in => regslice_both_resstream_V_keep_V_U_ack_in,
        data_out => resstream_TKEEP_int_regslice,
        vld_out => regslice_both_resstream_V_keep_V_U_vld_out,
        ack_out => resstream_TREADY_int_regslice,
        apdone_blk => regslice_both_resstream_V_keep_V_U_apdone_blk);

    regslice_both_resstream_V_strb_V_U : component iq_capture_regslice_both
    generic map (
        DataWidth => 32)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => resstream_TSTRB,
        vld_in => resstream_TVALID,
        ack_in => regslice_both_resstream_V_strb_V_U_ack_in,
        data_out => resstream_TSTRB_int_regslice,
        vld_out => regslice_both_resstream_V_strb_V_U_vld_out,
        ack_out => resstream_TREADY_int_regslice,
        apdone_blk => regslice_both_resstream_V_strb_V_U_apdone_blk);

    regslice_both_resstream_V_user_V_U : component iq_capture_regslice_both
    generic map (
        DataWidth => 8)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => resstream_TUSER,
        vld_in => resstream_TVALID,
        ack_in => regslice_both_resstream_V_user_V_U_ack_in,
        data_out => resstream_TUSER_int_regslice,
        vld_out => regslice_both_resstream_V_user_V_U_vld_out,
        ack_out => resstream_TREADY_int_regslice,
        apdone_blk => regslice_both_resstream_V_user_V_U_apdone_blk);

    regslice_both_resstream_V_last_V_U : component iq_capture_regslice_both
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => resstream_TLAST,
        vld_in => resstream_TVALID,
        ack_in => regslice_both_resstream_V_last_V_U_ack_in,
        data_out => resstream_TLAST_int_regslice,
        vld_out => regslice_both_resstream_V_last_V_U_vld_out,
        ack_out => resstream_TREADY_int_regslice,
        apdone_blk => regslice_both_resstream_V_last_V_U_apdone_blk);





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


    ap_enable_reg_pp0_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
            else
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_condition_pp0_exit_iter0_state3))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
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
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_condition_pp0_exit_iter0_state3))) then 
                    ap_enable_reg_pp0_iter1 <= (ap_const_logic_1 xor ap_condition_pp0_exit_iter0_state3);
                elsif ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i_fu_56_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then 
                i_fu_56 <= ap_const_lv35_0;
            elsif (((icmp_ln30_fu_108_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                i_fu_56 <= add_ln1057_fu_113_p2;
            end if; 
        end if;
    end process;

    keep_0_vld_reg_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((not(((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0))) and (keep_0_ack_out = ap_const_logic_1) and (ap_const_logic_1 = ap_const_logic_1) and (keep_0_vld_reg = ap_const_logic_1)) or (not(((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_const_logic_1) and (keep_0_vld_reg = ap_const_logic_0)))) then
                keep_0_data_reg <= keep;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln30_fu_108_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                p_Result_s_reg_164 <= p_Result_s_fu_127_p3;
                resin_reg_159 <= resstream_TDATA_int_regslice;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, ap_enable_reg_pp0_iter0, icmp_ln30_fu_108_p2, ap_block_pp0_stage0_subdone)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when ap_ST_fsm_pp0_stage0 => 
                if (not(((icmp_ln30_fu_108_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1)))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif (((icmp_ln30_fu_108_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state5;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_state5 => 
                ap_NS_fsm <= ap_ST_fsm_state6;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXXX";
        end case;
    end process;
    add_ln1057_fu_113_p2 <= std_logic_vector(unsigned(i_fu_56) + unsigned(ap_const_lv35_1));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(2);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state6 <= ap_CS_fsm(4);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start)
    begin
        if ((ap_start = ap_const_logic_0)) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state2_blk <= ap_const_logic_0;
    ap_ST_fsm_state5_blk <= ap_const_logic_0;
    ap_ST_fsm_state6_blk <= ap_const_logic_0;
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(fetched16_full_n, fetched_keep18_full_n, ap_enable_reg_pp0_iter0, icmp_ln30_fu_108_p2, ap_enable_reg_pp0_iter1, resstream_TVALID_int_regslice)
    begin
                ap_block_pp0_stage0_01001 <= (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and ((fetched_keep18_full_n = ap_const_logic_0) or (fetched16_full_n = ap_const_logic_0))) or ((icmp_ln30_fu_108_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (resstream_TVALID_int_regslice = ap_const_logic_0)));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(fetched16_full_n, fetched_keep18_full_n, ap_enable_reg_pp0_iter0, icmp_ln30_fu_108_p2, ap_enable_reg_pp0_iter1, resstream_TVALID_int_regslice)
    begin
                ap_block_pp0_stage0_11001 <= (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and ((fetched_keep18_full_n = ap_const_logic_0) or (fetched16_full_n = ap_const_logic_0))) or ((icmp_ln30_fu_108_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (resstream_TVALID_int_regslice = ap_const_logic_0)));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(fetched16_full_n, fetched_keep18_full_n, ap_enable_reg_pp0_iter0, icmp_ln30_fu_108_p2, ap_enable_reg_pp0_iter1, resstream_TVALID_int_regslice)
    begin
                ap_block_pp0_stage0_subdone <= (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and ((fetched_keep18_full_n = ap_const_logic_0) or (fetched16_full_n = ap_const_logic_0))) or ((icmp_ln30_fu_108_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (resstream_TVALID_int_regslice = ap_const_logic_0)));
    end process;


    ap_block_state3_pp0_stage0_iter0_assign_proc : process(icmp_ln30_fu_108_p2, resstream_TVALID_int_regslice)
    begin
                ap_block_state3_pp0_stage0_iter0 <= ((icmp_ln30_fu_108_p2 = ap_const_lv1_0) and (resstream_TVALID_int_regslice = ap_const_logic_0));
    end process;


    ap_block_state4_pp0_stage0_iter1_assign_proc : process(fetched16_full_n, fetched_keep18_full_n)
    begin
                ap_block_state4_pp0_stage0_iter1 <= ((fetched_keep18_full_n = ap_const_logic_0) or (fetched16_full_n = ap_const_logic_0));
    end process;


    ap_condition_pp0_exit_iter0_state3_assign_proc : process(icmp_ln30_fu_108_p2)
    begin
        if ((icmp_ln30_fu_108_p2 = ap_const_lv1_1)) then 
            ap_condition_pp0_exit_iter0_state3 <= ap_const_logic_1;
        else 
            ap_condition_pp0_exit_iter0_state3 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state6)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state6) or ((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
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


    ap_ready_assign_proc : process(ap_CS_fsm_state6)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    fetched16_blk_n_assign_proc : process(fetched16_full_n, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            fetched16_blk_n <= fetched16_full_n;
        else 
            fetched16_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    fetched16_din <= resin_reg_159;

    fetched16_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            fetched16_write <= ap_const_logic_1;
        else 
            fetched16_write <= ap_const_logic_0;
        end if; 
    end process;


    fetched_keep18_blk_n_assign_proc : process(fetched_keep18_full_n, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            fetched_keep18_blk_n <= fetched_keep18_full_n;
        else 
            fetched_keep18_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    fetched_keep18_din <= p_Result_s_reg_164;

    fetched_keep18_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_11001)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            fetched_keep18_write <= ap_const_logic_1;
        else 
            fetched_keep18_write <= ap_const_logic_0;
        end if; 
    end process;

    icmp_ln30_fu_108_p2 <= "1" when (i_fu_56 = capturesize) else "0";

    keep_0_ack_out_assign_proc : process(ap_CS_fsm_state2, ap_CS_fsm_state6)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state2) or (ap_const_logic_1 = ap_CS_fsm_state6))) then 
            keep_0_ack_out <= ap_const_logic_1;
        else 
            keep_0_ack_out <= ap_const_logic_0;
        end if; 
    end process;

    p_Result_s_fu_127_p3 <= keep_0_data_reg(to_integer(unsigned(resstream_TUSER_int_regslice)) downto to_integer(unsigned(resstream_TUSER_int_regslice))) when (to_integer(unsigned(resstream_TUSER_int_regslice))>= 0 and to_integer(unsigned(resstream_TUSER_int_regslice))<=255) else "-";

    resstream_TDATA_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, icmp_ln30_fu_108_p2, resstream_TVALID_int_regslice)
    begin
        if (((icmp_ln30_fu_108_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            resstream_TDATA_blk_n <= resstream_TVALID_int_regslice;
        else 
            resstream_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    resstream_TREADY <= regslice_both_resstream_V_data_V_U_ack_in;

    resstream_TREADY_int_regslice_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, icmp_ln30_fu_108_p2, ap_block_pp0_stage0_11001)
    begin
        if (((icmp_ln30_fu_108_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            resstream_TREADY_int_regslice <= ap_const_logic_1;
        else 
            resstream_TREADY_int_regslice <= ap_const_logic_0;
        end if; 
    end process;

end behav;
