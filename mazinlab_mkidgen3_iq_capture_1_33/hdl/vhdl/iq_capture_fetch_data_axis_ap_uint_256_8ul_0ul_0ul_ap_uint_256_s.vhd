-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity iq_capture_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    start_full_n : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    start_out : OUT STD_LOGIC;
    start_write : OUT STD_LOGIC;
    resstream_TDATA : IN STD_LOGIC_VECTOR (255 downto 0);
    resstream_TVALID : IN STD_LOGIC;
    resstream_TREADY : OUT STD_LOGIC;
    resstream_TKEEP : IN STD_LOGIC_VECTOR (31 downto 0);
    resstream_TSTRB : IN STD_LOGIC_VECTOR (31 downto 0);
    resstream_TUSER : IN STD_LOGIC_VECTOR (7 downto 0);
    resstream_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
    capturesize : IN STD_LOGIC_VECTOR (34 downto 0);
    keep : IN STD_LOGIC_VECTOR (255 downto 0);
    fetched16_din : OUT STD_LOGIC_VECTOR (255 downto 0);
    fetched16_full_n : IN STD_LOGIC;
    fetched16_write : OUT STD_LOGIC;
    fetched_keep18_din : OUT STD_LOGIC_VECTOR (0 downto 0);
    fetched_keep18_full_n : IN STD_LOGIC;
    fetched_keep18_write : OUT STD_LOGIC;
    total_capturesize_c_din : OUT STD_LOGIC_VECTOR (34 downto 0);
    total_capturesize_c_full_n : IN STD_LOGIC;
    total_capturesize_c_write : OUT STD_LOGIC );
end;


architecture behav of iq_capture_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";

attribute shreg_extract : string;
    signal real_start : STD_LOGIC;
    signal start_once_reg : STD_LOGIC := '0';
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal internal_ap_ready : STD_LOGIC;
    signal capturesize_0_data_reg : STD_LOGIC_VECTOR (34 downto 0) := "00000000000000000000000000000000000";
    signal capturesize_0_vld_reg : STD_LOGIC := '0';
    signal capturesize_0_ack_out : STD_LOGIC;
    signal keep_0_data_reg : STD_LOGIC_VECTOR (255 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    signal keep_0_vld_reg : STD_LOGIC := '0';
    signal keep_0_ack_out : STD_LOGIC;
    signal total_capturesize_c_blk_n : STD_LOGIC;
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_start : STD_LOGIC;
    signal grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done : STD_LOGIC;
    signal grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_idle : STD_LOGIC;
    signal grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_ready : STD_LOGIC;
    signal grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_resstream_TREADY : STD_LOGIC;
    signal grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched16_din : STD_LOGIC_VECTOR (255 downto 0);
    signal grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched16_write : STD_LOGIC;
    signal grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched_keep18_din : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched_keep18_write : STD_LOGIC;
    signal grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_block_state1 : BOOLEAN;
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
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

    component iq_capture_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read IS
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
    end component;


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
    grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76 : component iq_capture_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_start,
        ap_done => grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done,
        ap_idle => grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_idle,
        ap_ready => grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_ready,
        capturesize => capturesize_0_data_reg,
        resstream_TDATA => resstream_TDATA_int_regslice,
        resstream_TVALID => resstream_TVALID_int_regslice,
        resstream_TREADY => grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_resstream_TREADY,
        resstream_TKEEP => resstream_TKEEP_int_regslice,
        resstream_TSTRB => resstream_TSTRB_int_regslice,
        resstream_TUSER => resstream_TUSER_int_regslice,
        resstream_TLAST => resstream_TLAST_int_regslice,
        fetched16_din => grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched16_din,
        fetched16_full_n => fetched16_full_n,
        fetched16_write => grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched16_write,
        keep => keep_0_data_reg,
        fetched_keep18_din => grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched_keep18_din,
        fetched_keep18_full_n => fetched_keep18_full_n,
        fetched_keep18_write => grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched_keep18_write);

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


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((ap_const_logic_1 = ap_CS_fsm_state4) and (grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done = ap_const_logic_1))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_start_reg <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
                    grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_ready = ap_const_logic_1)) then 
                    grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    start_once_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                start_once_reg <= ap_const_logic_0;
            else
                if (((internal_ap_ready = ap_const_logic_0) and (real_start = ap_const_logic_1))) then 
                    start_once_reg <= ap_const_logic_1;
                elsif ((internal_ap_ready = ap_const_logic_1)) then 
                    start_once_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    capturesize_0_vld_reg_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
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
            if (((not(((ap_const_logic_1 = ap_CS_fsm_state1) and (real_start = ap_const_logic_0))) and (capturesize_0_ack_out = ap_const_logic_1) and (ap_const_logic_1 = ap_const_logic_1) and (capturesize_0_vld_reg = ap_const_logic_1)) or (not(((ap_const_logic_1 = ap_CS_fsm_state1) and (real_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_const_logic_1) and (capturesize_0_vld_reg = ap_const_logic_0)))) then
                capturesize_0_data_reg <= capturesize;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((not(((ap_const_logic_1 = ap_CS_fsm_state1) and (real_start = ap_const_logic_0))) and (keep_0_ack_out = ap_const_logic_1) and (ap_const_logic_1 = ap_const_logic_1) and (keep_0_vld_reg = ap_const_logic_1)) or (not(((ap_const_logic_1 = ap_CS_fsm_state1) and (real_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_const_logic_1) and (keep_0_vld_reg = ap_const_logic_0)))) then
                keep_0_data_reg <= keep;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (real_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, total_capturesize_c_full_n, ap_CS_fsm_state2, grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done, ap_CS_fsm_state4)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state2) and (total_capturesize_c_full_n = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state3;
                else
                    ap_NS_fsm <= ap_ST_fsm_state2;
                end if;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state4) and (grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state4;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);

    ap_ST_fsm_state1_blk_assign_proc : process(real_start, ap_done_reg)
    begin
        if (((ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_ST_fsm_state2_blk_assign_proc : process(total_capturesize_c_full_n)
    begin
        if ((total_capturesize_c_full_n = ap_const_logic_0)) then 
            ap_ST_fsm_state2_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state2_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state3_blk <= ap_const_logic_0;

    ap_ST_fsm_state4_blk_assign_proc : process(grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done)
    begin
        if ((grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state4_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state4_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(real_start, ap_done_reg)
    begin
                ap_block_state1 <= ((ap_done_reg = ap_const_logic_1) or (real_start = ap_const_logic_0));
    end process;


    ap_done_assign_proc : process(ap_done_reg, grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) and (grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done = ap_const_logic_1))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(real_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (real_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;

    ap_ready <= internal_ap_ready;

    capturesize_0_ack_out_assign_proc : process(total_capturesize_c_full_n, ap_CS_fsm_state2, grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done, ap_CS_fsm_state4)
    begin
        if ((((ap_const_logic_1 = ap_CS_fsm_state4) and (grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done = ap_const_logic_1)) or ((ap_const_logic_1 = ap_CS_fsm_state2) and (total_capturesize_c_full_n = ap_const_logic_1)))) then 
            capturesize_0_ack_out <= ap_const_logic_1;
        else 
            capturesize_0_ack_out <= ap_const_logic_0;
        end if; 
    end process;

    fetched16_din <= grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched16_din;

    fetched16_write_assign_proc : process(grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched16_write, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            fetched16_write <= grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched16_write;
        else 
            fetched16_write <= ap_const_logic_0;
        end if; 
    end process;

    fetched_keep18_din <= grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched_keep18_din;

    fetched_keep18_write_assign_proc : process(grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched_keep18_write, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            fetched_keep18_write <= grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_fetched_keep18_write;
        else 
            fetched_keep18_write <= ap_const_logic_0;
        end if; 
    end process;

    grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_start <= grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_start_reg;

    internal_ap_ready_assign_proc : process(grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) and (grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done = ap_const_logic_1))) then 
            internal_ap_ready <= ap_const_logic_1;
        else 
            internal_ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    keep_0_ack_out_assign_proc : process(total_capturesize_c_full_n, ap_CS_fsm_state2, grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done, ap_CS_fsm_state4)
    begin
        if ((((ap_const_logic_1 = ap_CS_fsm_state4) and (grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_ap_done = ap_const_logic_1)) or ((ap_const_logic_1 = ap_CS_fsm_state2) and (total_capturesize_c_full_n = ap_const_logic_1)))) then 
            keep_0_ack_out <= ap_const_logic_1;
        else 
            keep_0_ack_out <= ap_const_logic_0;
        end if; 
    end process;


    real_start_assign_proc : process(ap_start, start_full_n, start_once_reg)
    begin
        if (((start_once_reg = ap_const_logic_0) and (start_full_n = ap_const_logic_0))) then 
            real_start <= ap_const_logic_0;
        else 
            real_start <= ap_start;
        end if; 
    end process;

    resstream_TREADY <= regslice_both_resstream_V_data_V_U_ack_in;

    resstream_TREADY_int_regslice_assign_proc : process(grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_resstream_TREADY, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            resstream_TREADY_int_regslice <= grp_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_Pipeline_read_fu_76_resstream_TREADY;
        else 
            resstream_TREADY_int_regslice <= ap_const_logic_0;
        end if; 
    end process;

    start_out <= real_start;

    start_write_assign_proc : process(real_start, start_once_reg)
    begin
        if (((start_once_reg = ap_const_logic_0) and (real_start = ap_const_logic_1))) then 
            start_write <= ap_const_logic_1;
        else 
            start_write <= ap_const_logic_0;
        end if; 
    end process;


    total_capturesize_c_blk_n_assign_proc : process(total_capturesize_c_full_n, ap_CS_fsm_state2)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
            total_capturesize_c_blk_n <= total_capturesize_c_full_n;
        else 
            total_capturesize_c_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    total_capturesize_c_din <= capturesize_0_data_reg;

    total_capturesize_c_write_assign_proc : process(total_capturesize_c_full_n, ap_CS_fsm_state2)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state2) and (total_capturesize_c_full_n = ap_const_logic_1))) then 
            total_capturesize_c_write <= ap_const_logic_1;
        else 
            total_capturesize_c_write <= ap_const_logic_0;
        end if; 
    end process;

end behav;
