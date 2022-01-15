-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity write_axi256_getinstream is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    buf8_din : OUT STD_LOGIC_VECTOR (255 downto 0);
    buf8_full_n : IN STD_LOGIC;
    buf8_write : OUT STD_LOGIC;
    filtered_TVALID : IN STD_LOGIC;
    filtered_TDATA : IN STD_LOGIC_VECTOR (255 downto 0);
    filtered_TREADY : OUT STD_LOGIC;
    filtered_TKEEP : IN STD_LOGIC_VECTOR (31 downto 0);
    filtered_TSTRB : IN STD_LOGIC_VECTOR (31 downto 0);
    filtered_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
    capturesize : IN STD_LOGIC_VECTOR (26 downto 0) );
end;


architecture behav of write_axi256_getinstream is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_ST_fsm_pp0_stage1 : STD_LOGIC_VECTOR (1 downto 0) := "10";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv27_7FFFFFF : STD_LOGIC_VECTOR (26 downto 0) := "111111111111111111111111111";
    constant ap_const_lv27_7FFFFFE : STD_LOGIC_VECTOR (26 downto 0) := "111111111111111111111111110";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (1 downto 0) := "01";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage1 : signal is "none";
    signal sync_reg_83 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state2_pp0_stage1_iter0 : BOOLEAN;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_block_pp0_stage1_subdone : BOOLEAN;
    signal done_1_reg_257 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_condition_exit_pp0_iter0_stage1 : STD_LOGIC;
    signal ap_loop_exit_ready : STD_LOGIC;
    signal ap_ready_int : STD_LOGIC;
    signal filtered_TDATA_blk_n : STD_LOGIC;
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal ap_block_pp0_stage1 : BOOLEAN;
    signal buf8_blk_n : STD_LOGIC;
    signal and_ln188_reg_243 : STD_LOGIC_VECTOR (0 downto 0);
    signal reg_102 : STD_LOGIC_VECTOR (255 downto 0);
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal ap_block_pp0_stage1_11001 : BOOLEAN;
    signal tmp_4_reg_237 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln188_fu_147_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal count_1_fu_168_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal count_1_reg_247 : STD_LOGIC_VECTOR (31 downto 0);
    signal count_3_fu_180_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal count_3_reg_252 : STD_LOGIC_VECTOR (31 downto 0);
    signal done_1_fu_192_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal sync_1_fu_218_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal sync_1_reg_261 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_enable_reg_pp0_iter0_reg : STD_LOGIC := '0';
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_condition_exit_pp0_iter1_stage0 : STD_LOGIC;
    signal ap_idle_pp0_0to0 : STD_LOGIC;
    signal ap_phi_mux_sync_phi_fu_86_p4 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_loop_init : STD_LOGIC;
    signal count_fu_54 : STD_LOGIC_VECTOR (31 downto 0);
    signal count_2_fu_206_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_sig_allocacmp_count_load_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_sig_allocacmp_count_load : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_pp0_stage1_01001 : BOOLEAN;
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal sub_fu_107_p2 : STD_LOGIC_VECTOR (26 downto 0);
    signal sub8_fu_117_p2 : STD_LOGIC_VECTOR (26 downto 0);
    signal sub_cast_fu_113_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal or_ln188_fu_135_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln188_fu_141_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal zext_ln179_fu_123_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal icmp_ln194_fu_156_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal done_2_fu_174_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal done_fu_162_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal done_3_fu_186_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal count_4_fu_200_p3 : STD_LOGIC_VECTOR (31 downto 0);
    signal or_ln205_fu_213_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_continue_int : STD_LOGIC;
    signal ap_done_int : STD_LOGIC;
    signal ap_loop_exit_ready_pp0_iter1_reg : STD_LOGIC;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_idle_pp0_1to1 : STD_LOGIC;
    signal ap_done_pending_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_start_int : STD_LOGIC;
    signal regslice_both_filtered_V_data_V_U_apdone_blk : STD_LOGIC;
    signal filtered_TDATA_int_regslice : STD_LOGIC_VECTOR (255 downto 0);
    signal filtered_TVALID_int_regslice : STD_LOGIC;
    signal filtered_TREADY_int_regslice : STD_LOGIC;
    signal regslice_both_filtered_V_data_V_U_ack_in : STD_LOGIC;
    signal regslice_both_filtered_V_keep_V_U_apdone_blk : STD_LOGIC;
    signal filtered_TKEEP_int_regslice : STD_LOGIC_VECTOR (31 downto 0);
    signal regslice_both_filtered_V_keep_V_U_vld_out : STD_LOGIC;
    signal regslice_both_filtered_V_keep_V_U_ack_in : STD_LOGIC;
    signal regslice_both_filtered_V_strb_V_U_apdone_blk : STD_LOGIC;
    signal filtered_TSTRB_int_regslice : STD_LOGIC_VECTOR (31 downto 0);
    signal regslice_both_filtered_V_strb_V_U_vld_out : STD_LOGIC;
    signal regslice_both_filtered_V_strb_V_U_ack_in : STD_LOGIC;
    signal regslice_both_filtered_V_last_V_U_apdone_blk : STD_LOGIC;
    signal filtered_TLAST_int_regslice : STD_LOGIC_VECTOR (0 downto 0);
    signal regslice_both_filtered_V_last_V_U_vld_out : STD_LOGIC;
    signal regslice_both_filtered_V_last_V_U_ack_in : STD_LOGIC;
    signal ap_condition_339 : BOOLEAN;
    signal ap_condition_343 : BOOLEAN;
    signal ap_condition_346 : BOOLEAN;
    signal ap_condition_351 : BOOLEAN;
    signal ap_ce_reg : STD_LOGIC;

    component write_axi256_flow_control_loop_pipe IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_start_int : OUT STD_LOGIC;
        ap_loop_init : OUT STD_LOGIC;
        ap_ready_int : IN STD_LOGIC;
        ap_loop_exit_ready : IN STD_LOGIC;
        ap_loop_exit_done : IN STD_LOGIC;
        ap_continue_int : OUT STD_LOGIC;
        ap_done_int : IN STD_LOGIC;
        ap_continue : IN STD_LOGIC );
    end component;


    component write_axi256_regslice_both IS
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
    flow_control_loop_pipe_U : component write_axi256_flow_control_loop_pipe
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => ap_start,
        ap_ready => ap_ready,
        ap_done => ap_done,
        ap_start_int => ap_start_int,
        ap_loop_init => ap_loop_init,
        ap_ready_int => ap_ready_int,
        ap_loop_exit_ready => ap_condition_exit_pp0_iter0_stage1,
        ap_loop_exit_done => ap_done_int,
        ap_continue_int => ap_continue_int,
        ap_done_int => ap_done_int,
        ap_continue => ap_continue);

    regslice_both_filtered_V_data_V_U : component write_axi256_regslice_both
    generic map (
        DataWidth => 256)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => filtered_TDATA,
        vld_in => filtered_TVALID,
        ack_in => regslice_both_filtered_V_data_V_U_ack_in,
        data_out => filtered_TDATA_int_regslice,
        vld_out => filtered_TVALID_int_regslice,
        ack_out => filtered_TREADY_int_regslice,
        apdone_blk => regslice_both_filtered_V_data_V_U_apdone_blk);

    regslice_both_filtered_V_keep_V_U : component write_axi256_regslice_both
    generic map (
        DataWidth => 32)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => filtered_TKEEP,
        vld_in => filtered_TVALID,
        ack_in => regslice_both_filtered_V_keep_V_U_ack_in,
        data_out => filtered_TKEEP_int_regslice,
        vld_out => regslice_both_filtered_V_keep_V_U_vld_out,
        ack_out => filtered_TREADY_int_regslice,
        apdone_blk => regslice_both_filtered_V_keep_V_U_apdone_blk);

    regslice_both_filtered_V_strb_V_U : component write_axi256_regslice_both
    generic map (
        DataWidth => 32)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => filtered_TSTRB,
        vld_in => filtered_TVALID,
        ack_in => regslice_both_filtered_V_strb_V_U_ack_in,
        data_out => filtered_TSTRB_int_regslice,
        vld_out => regslice_both_filtered_V_strb_V_U_vld_out,
        ack_out => filtered_TREADY_int_regslice,
        apdone_blk => regslice_both_filtered_V_strb_V_U_apdone_blk);

    regslice_both_filtered_V_last_V_U : component write_axi256_regslice_both
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => filtered_TLAST,
        vld_in => filtered_TVALID,
        ack_in => regslice_both_filtered_V_last_V_U_ack_in,
        data_out => filtered_TLAST_int_regslice,
        vld_out => regslice_both_filtered_V_last_V_U_vld_out,
        ack_out => filtered_TREADY_int_regslice,
        apdone_blk => regslice_both_filtered_V_last_V_U_apdone_blk);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
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
                if ((ap_continue_int = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter1_reg = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0_reg <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) then 
                    ap_enable_reg_pp0_iter0_reg <= ap_start_int;
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
                if ((((ap_const_logic_1 = ap_condition_exit_pp0_iter1_stage0) and (ap_idle_pp0_0to0 = ap_const_logic_1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage1_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
                    ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                end if; 
            end if;
        end if;
    end process;


    ap_loop_exit_ready_pp0_iter1_reg_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((((ap_loop_exit_ready = ap_const_logic_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((ap_const_logic_1 = ap_condition_exit_pp0_iter1_stage0) and (ap_idle_pp0_0to0 = ap_const_logic_1)))) then 
                ap_loop_exit_ready_pp0_iter1_reg <= ap_const_logic_0;
            elsif (((ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
                ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
            end if; 
        end if;
    end process;

    count_fu_54_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_enable_reg_pp0_iter0 = ap_const_logic_1)) then
                if ((ap_const_boolean_1 = ap_condition_346)) then 
                    count_fu_54 <= ap_const_lv32_0;
                elsif ((ap_const_boolean_1 = ap_condition_343)) then 
                    count_fu_54 <= count_2_fu_206_p3;
                end if;
            end if; 
        end if;
    end process;

    sync_reg_83_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) then
                if ((ap_const_boolean_1 = ap_condition_351)) then 
                    sync_reg_83 <= sync_1_reg_261;
                elsif (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_init = ap_const_logic_1))) then 
                    sync_reg_83 <= ap_const_lv1_0;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                and_ln188_reg_243 <= and_ln188_fu_147_p2;
                count_1_reg_247 <= count_1_fu_168_p2;
                count_3_reg_252 <= count_3_fu_180_p2;
                done_1_reg_257 <= done_1_fu_192_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((((ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then
                reg_102 <= filtered_TDATA_int_regslice;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then
                sync_1_reg_261 <= sync_1_fu_218_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                tmp_4_reg_237 <= filtered_TLAST_int_regslice;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage1_subdone, ap_block_pp0_stage0_subdone, ap_condition_exit_pp0_iter1_stage0, ap_idle_pp0_0to0, ap_idle_pp0_1to1, ap_done_pending_pp0, ap_start_int)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                if (((ap_const_logic_1 = ap_condition_exit_pp0_iter1_stage0) and (ap_idle_pp0_0to0 = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif ((not(((ap_start_int = ap_const_logic_0) and (ap_done_pending_pp0 = ap_const_logic_0) and (ap_idle_pp0_1to1 = ap_const_logic_1))) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_pp0_stage1 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage1_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                end if;
            when others =>  
                ap_NS_fsm <= "XX";
        end case;
    end process;
    and_ln188_fu_147_p2 <= (or_ln188_fu_135_p2 and icmp_ln188_fu_141_p2);
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
    ap_CS_fsm_pp0_stage1 <= ap_CS_fsm(1);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, buf8_full_n, ap_done_reg, and_ln188_reg_243, filtered_TVALID_int_regslice)
    begin
                ap_block_pp0_stage0_01001 <= (((ap_const_lv1_1 = and_ln188_reg_243) and (buf8_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and ((ap_done_reg = ap_const_logic_1) or (filtered_TVALID_int_regslice = ap_const_logic_0))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, buf8_full_n, ap_done_reg, and_ln188_reg_243, filtered_TVALID_int_regslice)
    begin
                ap_block_pp0_stage0_11001 <= (((ap_const_lv1_1 = and_ln188_reg_243) and (buf8_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and ((ap_done_reg = ap_const_logic_1) or (filtered_TVALID_int_regslice = ap_const_logic_0))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, buf8_full_n, ap_done_reg, and_ln188_reg_243, filtered_TVALID_int_regslice)
    begin
                ap_block_pp0_stage0_subdone <= (((ap_const_lv1_1 = and_ln188_reg_243) and (buf8_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and ((ap_done_reg = ap_const_logic_1) or (filtered_TVALID_int_regslice = ap_const_logic_0))));
    end process;

        ap_block_pp0_stage1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage1_01001_assign_proc : process(ap_enable_reg_pp0_iter0, buf8_full_n, sync_reg_83, ap_done_reg, filtered_TVALID_int_regslice)
    begin
                ap_block_pp0_stage1_01001 <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and ((filtered_TVALID_int_regslice = ap_const_logic_0) or ((sync_reg_83 = ap_const_lv1_1) and (buf8_full_n = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage1_11001_assign_proc : process(ap_enable_reg_pp0_iter0, buf8_full_n, sync_reg_83, ap_done_reg, filtered_TVALID_int_regslice)
    begin
                ap_block_pp0_stage1_11001 <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and ((filtered_TVALID_int_regslice = ap_const_logic_0) or ((sync_reg_83 = ap_const_lv1_1) and (buf8_full_n = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage1_subdone_assign_proc : process(ap_enable_reg_pp0_iter0, buf8_full_n, sync_reg_83, ap_done_reg, filtered_TVALID_int_regslice)
    begin
                ap_block_pp0_stage1_subdone <= ((ap_done_reg = ap_const_logic_1) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and ((filtered_TVALID_int_regslice = ap_const_logic_0) or ((sync_reg_83 = ap_const_lv1_1) and (buf8_full_n = ap_const_logic_0)))));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(ap_done_reg, filtered_TVALID_int_regslice)
    begin
                ap_block_state1_pp0_stage0_iter0 <= ((ap_done_reg = ap_const_logic_1) or (filtered_TVALID_int_regslice = ap_const_logic_0));
    end process;


    ap_block_state2_pp0_stage1_iter0_assign_proc : process(buf8_full_n, sync_reg_83, filtered_TVALID_int_regslice)
    begin
                ap_block_state2_pp0_stage1_iter0 <= ((filtered_TVALID_int_regslice = ap_const_logic_0) or ((sync_reg_83 = ap_const_lv1_1) and (buf8_full_n = ap_const_logic_0)));
    end process;


    ap_block_state3_pp0_stage0_iter1_assign_proc : process(buf8_full_n, and_ln188_reg_243)
    begin
                ap_block_state3_pp0_stage0_iter1 <= ((ap_const_lv1_1 = and_ln188_reg_243) and (buf8_full_n = ap_const_logic_0));
    end process;


    ap_condition_339_assign_proc : process(ap_enable_reg_pp0_iter1, done_1_reg_257, ap_block_pp0_stage0)
    begin
                ap_condition_339 <= ((done_1_reg_257 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1));
    end process;


    ap_condition_343_assign_proc : process(ap_CS_fsm_pp0_stage1, done_1_reg_257, ap_block_pp0_stage1_11001)
    begin
                ap_condition_343 <= ((done_1_reg_257 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1));
    end process;


    ap_condition_346_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_loop_init)
    begin
                ap_condition_346 <= ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1));
    end process;


    ap_condition_351_assign_proc : process(ap_enable_reg_pp0_iter1, done_1_reg_257, ap_block_pp0_stage0_11001)
    begin
                ap_condition_351 <= ((done_1_reg_257 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1));
    end process;


    ap_condition_exit_pp0_iter0_stage1_assign_proc : process(ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage1_subdone, done_1_reg_257)
    begin
        if (((done_1_reg_257 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage1_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            ap_condition_exit_pp0_iter0_stage1 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter0_stage1 <= ap_const_logic_0;
        end if; 
    end process;


    ap_condition_exit_pp0_iter1_stage0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, done_1_reg_257, ap_block_pp0_stage0_subdone)
    begin
        if (((done_1_reg_257 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_condition_exit_pp0_iter1_stage0 <= ap_const_logic_1;
        else 
            ap_condition_exit_pp0_iter1_stage0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_done_reg, ap_block_pp0_stage0_subdone, ap_loop_exit_ready_pp0_iter1_reg)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_loop_exit_ready_pp0_iter1_reg = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            ap_done_int <= ap_const_logic_1;
        else 
            ap_done_int <= ap_done_reg;
        end if; 
    end process;


    ap_done_pending_pp0_assign_proc : process(ap_loop_exit_ready, ap_loop_exit_ready_pp0_iter1_reg)
    begin
        if (not(((ap_loop_exit_ready = ap_const_logic_0) and (ap_loop_exit_ready_pp0_iter1_reg = ap_const_logic_0)))) then 
            ap_done_pending_pp0 <= ap_const_logic_1;
        else 
            ap_done_pending_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_enable_reg_pp0_iter0_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0_reg, ap_start_int)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) then 
            ap_enable_reg_pp0_iter0 <= ap_start_int;
        else 
            ap_enable_reg_pp0_iter0 <= ap_enable_reg_pp0_iter0_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_idle_pp0, ap_start_int)
    begin
        if (((ap_start_int = ap_const_logic_0) and (ap_idle_pp0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
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


    ap_idle_pp0_0to0_assign_proc : process(ap_enable_reg_pp0_iter0)
    begin
        if ((ap_enable_reg_pp0_iter0 = ap_const_logic_0)) then 
            ap_idle_pp0_0to0 <= ap_const_logic_1;
        else 
            ap_idle_pp0_0to0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_1to1_assign_proc : process(ap_enable_reg_pp0_iter1)
    begin
        if ((ap_enable_reg_pp0_iter1 = ap_const_logic_0)) then 
            ap_idle_pp0_1to1 <= ap_const_logic_1;
        else 
            ap_idle_pp0_1to1 <= ap_const_logic_0;
        end if; 
    end process;

    ap_loop_exit_ready <= ap_condition_exit_pp0_iter0_stage1;

    ap_phi_mux_sync_phi_fu_86_p4_assign_proc : process(ap_CS_fsm_pp0_stage0, sync_1_reg_261, ap_loop_init, ap_condition_339)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) then
            if ((ap_const_boolean_1 = ap_condition_339)) then 
                ap_phi_mux_sync_phi_fu_86_p4 <= sync_1_reg_261;
            elsif ((ap_loop_init = ap_const_logic_1)) then 
                ap_phi_mux_sync_phi_fu_86_p4 <= ap_const_lv1_0;
            else 
                ap_phi_mux_sync_phi_fu_86_p4 <= sync_1_reg_261;
            end if;
        else 
            ap_phi_mux_sync_phi_fu_86_p4 <= sync_1_reg_261;
        end if; 
    end process;


    ap_ready_int_assign_proc : process(ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage1_subdone)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage1_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            ap_ready_int <= ap_const_logic_1;
        else 
            ap_ready_int <= ap_const_logic_0;
        end if; 
    end process;


    ap_sig_allocacmp_count_load_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, ap_loop_init, count_fu_54)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
            ap_sig_allocacmp_count_load <= ap_const_lv32_0;
        else 
            ap_sig_allocacmp_count_load <= count_fu_54;
        end if; 
    end process;


    ap_sig_allocacmp_count_load_1_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, ap_loop_init, count_fu_54)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_loop_init = ap_const_logic_1))) then 
            ap_sig_allocacmp_count_load_1 <= ap_const_lv32_0;
        else 
            ap_sig_allocacmp_count_load_1 <= count_fu_54;
        end if; 
    end process;


    buf8_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_CS_fsm_pp0_stage1, buf8_full_n, sync_reg_83, ap_block_pp0_stage0, ap_block_pp0_stage1, and_ln188_reg_243)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage1) and (sync_reg_83 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_lv1_1 = and_ln188_reg_243) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            buf8_blk_n <= buf8_full_n;
        else 
            buf8_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    buf8_din <= reg_102;

    buf8_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter1, ap_CS_fsm_pp0_stage1, sync_reg_83, and_ln188_reg_243, ap_block_pp0_stage0_11001, ap_block_pp0_stage1_11001)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (sync_reg_83 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_lv1_1 = and_ln188_reg_243) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            buf8_write <= ap_const_logic_1;
        else 
            buf8_write <= ap_const_logic_0;
        end if; 
    end process;

    count_1_fu_168_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_count_load) + unsigned(ap_const_lv32_2));
    count_2_fu_206_p3 <= 
        count_1_reg_247 when (sync_reg_83(0) = '1') else 
        count_4_fu_200_p3;
    count_3_fu_180_p2 <= std_logic_vector(unsigned(ap_sig_allocacmp_count_load) + unsigned(ap_const_lv32_1));
    count_4_fu_200_p3 <= 
        count_3_reg_252 when (tmp_4_reg_237(0) = '1') else 
        ap_const_lv32_0;
    done_1_fu_192_p3 <= 
        done_fu_162_p2 when (ap_phi_mux_sync_phi_fu_86_p4(0) = '1') else 
        done_3_fu_186_p2;
    done_2_fu_174_p2 <= "1" when (ap_sig_allocacmp_count_load = ap_const_lv32_1) else "0";
    done_3_fu_186_p2 <= (filtered_TLAST_int_regslice and done_2_fu_174_p2);
    done_fu_162_p2 <= (icmp_ln194_fu_156_p2 xor ap_const_lv1_1);

    filtered_TDATA_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, ap_done_reg, ap_block_pp0_stage0, ap_block_pp0_stage1, filtered_TVALID_int_regslice)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_done_reg = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            filtered_TDATA_blk_n <= filtered_TVALID_int_regslice;
        else 
            filtered_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    filtered_TREADY <= regslice_both_filtered_V_data_V_U_ack_in;

    filtered_TREADY_int_regslice_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage0_11001, ap_block_pp0_stage1_11001)
    begin
        if ((((ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            filtered_TREADY_int_regslice <= ap_const_logic_1;
        else 
            filtered_TREADY_int_regslice <= ap_const_logic_0;
        end if; 
    end process;

    icmp_ln188_fu_141_p2 <= "1" when (signed(ap_sig_allocacmp_count_load_1) < signed(sub_cast_fu_113_p1)) else "0";
    icmp_ln194_fu_156_p2 <= "1" when (signed(ap_sig_allocacmp_count_load) < signed(zext_ln179_fu_123_p1)) else "0";
    or_ln188_fu_135_p2 <= (filtered_TLAST_int_regslice or ap_phi_mux_sync_phi_fu_86_p4);
    or_ln205_fu_213_p2 <= (tmp_4_reg_237 or filtered_TLAST_int_regslice);
    sub8_fu_117_p2 <= std_logic_vector(unsigned(capturesize) + unsigned(ap_const_lv27_7FFFFFE));
    sub_cast_fu_113_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(sub_fu_107_p2),32));
    sub_fu_107_p2 <= std_logic_vector(unsigned(capturesize) + unsigned(ap_const_lv27_7FFFFFF));
    sync_1_fu_218_p2 <= (sync_reg_83 or or_ln205_fu_213_p2);
    zext_ln179_fu_123_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(sub8_fu_117_p2),32));
end behav;
