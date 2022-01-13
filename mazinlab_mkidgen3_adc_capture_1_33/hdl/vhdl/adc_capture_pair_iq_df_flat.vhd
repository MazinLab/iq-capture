-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adc_capture_pair_iq_df_flat is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    istream_V_TDATA : IN STD_LOGIC_VECTOR (127 downto 0);
    istream_V_TVALID : IN STD_LOGIC;
    istream_V_TREADY : OUT STD_LOGIC;
    qstream_V_TDATA : IN STD_LOGIC_VECTOR (127 downto 0);
    qstream_V_TVALID : IN STD_LOGIC;
    qstream_V_TREADY : OUT STD_LOGIC;
    capturesize : IN STD_LOGIC_VECTOR (26 downto 0);
    iq_in8_din : OUT STD_LOGIC_VECTOR (255 downto 0);
    iq_in8_full_n : IN STD_LOGIC;
    iq_in8_write : OUT STD_LOGIC );
end;


architecture behav of adc_capture_pair_iq_df_flat is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (4 downto 0) := "00010";
    constant ap_ST_fsm_pp0_stage1 : STD_LOGIC_VECTOR (4 downto 0) := "00100";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (4 downto 0) := "01000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (4 downto 0) := "10000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
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
    constant ap_const_lv32_1E : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000011110";
    constant ap_const_lv30_0 : STD_LOGIC_VECTOR (29 downto 0) := "000000000000000000000000000000";
    constant ap_const_lv31_7FFFFFFE : STD_LOGIC_VECTOR (30 downto 0) := "1111111111111111111111111111110";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (4 downto 0) := "00001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal istream_V_TDATA_blk_n : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal icmp_ln81_fu_329_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_pp0_stage1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage1 : signal is "none";
    signal ap_block_pp0_stage1 : BOOLEAN;
    signal icmp_ln81_reg_438 : STD_LOGIC_VECTOR (0 downto 0);
    signal qstream_V_TDATA_blk_n : STD_LOGIC;
    signal iq_in8_blk_n : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal reg_251 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_block_state2_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal ap_block_state3_pp0_stage1_iter0 : BOOLEAN;
    signal ap_block_pp0_stage1_11001 : BOOLEAN;
    signal reg_255 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_259 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_263 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_267 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_271 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_275 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_279 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_283 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_287 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_291 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_295 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_299 : STD_LOGIC_VECTOR (15 downto 0);
    signal reg_303 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_fu_335_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_reg_442 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_1_fu_339_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_1_reg_447 : STD_LOGIC_VECTOR (15 downto 0);
    signal i_3_fu_343_p2 : STD_LOGIC_VECTOR (30 downto 0);
    signal i_3_reg_452 : STD_LOGIC_VECTOR (30 downto 0);
    signal trunc_ln674_2_fu_384_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_2_reg_457 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_3_fu_388_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_3_reg_462 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_block_state1 : BOOLEAN;
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_condition_pp0_exit_iter0_state2 : STD_LOGIC;
    signal ap_block_pp0_stage1_subdone : BOOLEAN;
    signal i_fu_82 : STD_LOGIC_VECTOR (30 downto 0);
    signal zext_ln81_fu_307_p1 : STD_LOGIC_VECTOR (30 downto 0);
    signal p_Result_11_7_fu_349_p17 : STD_LOGIC_VECTOR (255 downto 0);
    signal ap_block_pp0_stage1_01001 : BOOLEAN;
    signal p_Result_19_7_fu_396_p17 : STD_LOGIC_VECTOR (255 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal tmp_fu_319_p4 : STD_LOGIC_VECTOR (29 downto 0);
    signal ap_CS_fsm_state6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state6 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (4 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state5_blk : STD_LOGIC;
    signal ap_ST_fsm_state6_blk : STD_LOGIC;
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal regslice_both_istream_V_U_apdone_blk : STD_LOGIC;
    signal istream_V_TDATA_int_regslice : STD_LOGIC_VECTOR (127 downto 0);
    signal istream_V_TVALID_int_regslice : STD_LOGIC;
    signal istream_V_TREADY_int_regslice : STD_LOGIC;
    signal regslice_both_istream_V_U_ack_in : STD_LOGIC;
    signal regslice_both_qstream_V_U_apdone_blk : STD_LOGIC;
    signal qstream_V_TDATA_int_regslice : STD_LOGIC_VECTOR (127 downto 0);
    signal qstream_V_TVALID_int_regslice : STD_LOGIC;
    signal qstream_V_TREADY_int_regslice : STD_LOGIC;
    signal regslice_both_qstream_V_U_ack_in : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component adc_capture_regslice_both IS
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
    regslice_both_istream_V_U : component adc_capture_regslice_both
    generic map (
        DataWidth => 128)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => istream_V_TDATA,
        vld_in => istream_V_TVALID,
        ack_in => regslice_both_istream_V_U_ack_in,
        data_out => istream_V_TDATA_int_regslice,
        vld_out => istream_V_TVALID_int_regslice,
        ack_out => istream_V_TREADY_int_regslice,
        apdone_blk => regslice_both_istream_V_U_apdone_blk);

    regslice_both_qstream_V_U : component adc_capture_regslice_both
    generic map (
        DataWidth => 128)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        data_in => qstream_V_TDATA,
        vld_in => qstream_V_TVALID,
        ack_in => regslice_both_qstream_V_U_ack_in,
        data_out => qstream_V_TDATA_int_regslice,
        vld_out => qstream_V_TVALID_int_regslice,
        ack_out => qstream_V_TREADY_int_regslice,
        apdone_blk => regslice_both_qstream_V_U_apdone_blk);





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
                elsif ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
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
                if ((((ap_const_boolean_0 = ap_block_pp0_stage1_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
                    ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                elsif ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i_fu_82_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                i_fu_82 <= zext_ln81_fu_307_p1;
            elsif (((icmp_ln81_reg_438 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
                i_fu_82 <= i_3_reg_452;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                i_3_reg_452 <= i_3_fu_343_p2;
                trunc_ln674_1_reg_447 <= trunc_ln674_1_fu_339_p1;
                trunc_ln674_reg_442 <= trunc_ln674_fu_335_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln81_reg_438 <= icmp_ln81_fu_329_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((((icmp_ln81_reg_438 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then
                reg_251 <= istream_V_TDATA_int_regslice(31 downto 16);
                reg_255 <= qstream_V_TDATA_int_regslice(31 downto 16);
                reg_259 <= istream_V_TDATA_int_regslice(47 downto 32);
                reg_263 <= qstream_V_TDATA_int_regslice(47 downto 32);
                reg_267 <= istream_V_TDATA_int_regslice(63 downto 48);
                reg_271 <= qstream_V_TDATA_int_regslice(63 downto 48);
                reg_275 <= istream_V_TDATA_int_regslice(79 downto 64);
                reg_279 <= qstream_V_TDATA_int_regslice(79 downto 64);
                reg_283 <= istream_V_TDATA_int_regslice(95 downto 80);
                reg_287 <= qstream_V_TDATA_int_regslice(95 downto 80);
                reg_291 <= istream_V_TDATA_int_regslice(111 downto 96);
                reg_295 <= qstream_V_TDATA_int_regslice(111 downto 96);
                reg_299 <= istream_V_TDATA_int_regslice(127 downto 112);
                reg_303 <= qstream_V_TDATA_int_regslice(127 downto 112);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln81_reg_438 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then
                trunc_ln674_2_reg_457 <= trunc_ln674_2_fu_384_p1;
                trunc_ln674_3_reg_462 <= trunc_ln674_3_fu_388_p1;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, ap_enable_reg_pp0_iter0, icmp_ln81_fu_329_p2, ap_block_pp0_stage0_subdone, ap_block_pp0_stage1_subdone)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_pp0_stage0 => 
                if ((not(((icmp_ln81_fu_329_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                elsif (((icmp_ln81_fu_329_p2 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state5;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_pp0_stage1 => 
                if ((ap_const_boolean_0 = ap_block_pp0_stage1_subdone)) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage1;
                end if;
            when ap_ST_fsm_state5 => 
                ap_NS_fsm <= ap_ST_fsm_state6;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXXXX";
        end case;
    end process;
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(1);
    ap_CS_fsm_pp0_stage1 <= ap_CS_fsm(2);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state6 <= ap_CS_fsm(4);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start, ap_done_reg)
    begin
        if (((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state5_blk <= ap_const_logic_0;
    ap_ST_fsm_state6_blk <= ap_const_logic_0;
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(iq_in8_full_n, ap_enable_reg_pp0_iter0, icmp_ln81_fu_329_p2, ap_enable_reg_pp0_iter1, istream_V_TVALID_int_regslice, qstream_V_TVALID_int_regslice)
    begin
                ap_block_pp0_stage0_01001 <= (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (iq_in8_full_n = ap_const_logic_0)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (qstream_V_TVALID_int_regslice = ap_const_logic_0)) or ((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (istream_V_TVALID_int_regslice = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(iq_in8_full_n, ap_enable_reg_pp0_iter0, icmp_ln81_fu_329_p2, ap_enable_reg_pp0_iter1, istream_V_TVALID_int_regslice, qstream_V_TVALID_int_regslice)
    begin
                ap_block_pp0_stage0_11001 <= (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (iq_in8_full_n = ap_const_logic_0)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (qstream_V_TVALID_int_regslice = ap_const_logic_0)) or ((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (istream_V_TVALID_int_regslice = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(iq_in8_full_n, ap_enable_reg_pp0_iter0, icmp_ln81_fu_329_p2, ap_enable_reg_pp0_iter1, istream_V_TVALID_int_regslice, qstream_V_TVALID_int_regslice)
    begin
                ap_block_pp0_stage0_subdone <= (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (iq_in8_full_n = ap_const_logic_0)) or ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (qstream_V_TVALID_int_regslice = ap_const_logic_0)) or ((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (istream_V_TVALID_int_regslice = ap_const_logic_0)))));
    end process;

        ap_block_pp0_stage1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage1_01001_assign_proc : process(iq_in8_full_n, ap_enable_reg_pp0_iter0, icmp_ln81_reg_438, istream_V_TVALID_int_regslice, qstream_V_TVALID_int_regslice)
    begin
                ap_block_pp0_stage1_01001 <= ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln81_reg_438 = ap_const_lv1_0) and (iq_in8_full_n = ap_const_logic_0)) or ((icmp_ln81_reg_438 = ap_const_lv1_0) and (qstream_V_TVALID_int_regslice = ap_const_logic_0)) or ((icmp_ln81_reg_438 = ap_const_lv1_0) and (istream_V_TVALID_int_regslice = ap_const_logic_0))));
    end process;


    ap_block_pp0_stage1_11001_assign_proc : process(iq_in8_full_n, ap_enable_reg_pp0_iter0, icmp_ln81_reg_438, istream_V_TVALID_int_regslice, qstream_V_TVALID_int_regslice)
    begin
                ap_block_pp0_stage1_11001 <= ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln81_reg_438 = ap_const_lv1_0) and (iq_in8_full_n = ap_const_logic_0)) or ((icmp_ln81_reg_438 = ap_const_lv1_0) and (qstream_V_TVALID_int_regslice = ap_const_logic_0)) or ((icmp_ln81_reg_438 = ap_const_lv1_0) and (istream_V_TVALID_int_regslice = ap_const_logic_0))));
    end process;


    ap_block_pp0_stage1_subdone_assign_proc : process(iq_in8_full_n, ap_enable_reg_pp0_iter0, icmp_ln81_reg_438, istream_V_TVALID_int_regslice, qstream_V_TVALID_int_regslice)
    begin
                ap_block_pp0_stage1_subdone <= ((ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (((icmp_ln81_reg_438 = ap_const_lv1_0) and (iq_in8_full_n = ap_const_logic_0)) or ((icmp_ln81_reg_438 = ap_const_lv1_0) and (qstream_V_TVALID_int_regslice = ap_const_logic_0)) or ((icmp_ln81_reg_438 = ap_const_lv1_0) and (istream_V_TVALID_int_regslice = ap_const_logic_0))));
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg)
    begin
                ap_block_state1 <= ((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0));
    end process;


    ap_block_state2_pp0_stage0_iter0_assign_proc : process(icmp_ln81_fu_329_p2, istream_V_TVALID_int_regslice, qstream_V_TVALID_int_regslice)
    begin
                ap_block_state2_pp0_stage0_iter0 <= (((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (qstream_V_TVALID_int_regslice = ap_const_logic_0)) or ((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (istream_V_TVALID_int_regslice = ap_const_logic_0)));
    end process;


    ap_block_state3_pp0_stage1_iter0_assign_proc : process(iq_in8_full_n, icmp_ln81_reg_438, istream_V_TVALID_int_regslice, qstream_V_TVALID_int_regslice)
    begin
                ap_block_state3_pp0_stage1_iter0 <= (((icmp_ln81_reg_438 = ap_const_lv1_0) and (iq_in8_full_n = ap_const_logic_0)) or ((icmp_ln81_reg_438 = ap_const_lv1_0) and (qstream_V_TVALID_int_regslice = ap_const_logic_0)) or ((icmp_ln81_reg_438 = ap_const_lv1_0) and (istream_V_TVALID_int_regslice = ap_const_logic_0)));
    end process;


    ap_block_state4_pp0_stage0_iter1_assign_proc : process(iq_in8_full_n)
    begin
                ap_block_state4_pp0_stage0_iter1 <= (iq_in8_full_n = ap_const_logic_0);
    end process;


    ap_condition_pp0_exit_iter0_state2_assign_proc : process(icmp_ln81_fu_329_p2)
    begin
        if ((icmp_ln81_fu_329_p2 = ap_const_lv1_1)) then 
            ap_condition_pp0_exit_iter0_state2 <= ap_const_logic_1;
        else 
            ap_condition_pp0_exit_iter0_state2 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state6)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
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


    ap_ready_assign_proc : process(ap_CS_fsm_state6)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;

    i_3_fu_343_p2 <= std_logic_vector(unsigned(i_fu_82) + unsigned(ap_const_lv31_7FFFFFFE));
    icmp_ln81_fu_329_p2 <= "1" when (tmp_fu_319_p4 = ap_const_lv30_0) else "0";

    iq_in8_blk_n_assign_proc : process(iq_in8_full_n, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage1, icmp_ln81_reg_438, ap_enable_reg_pp0_iter1)
    begin
        if ((((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((icmp_ln81_reg_438 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)))) then 
            iq_in8_blk_n <= iq_in8_full_n;
        else 
            iq_in8_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    iq_in8_din_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, icmp_ln81_reg_438, ap_enable_reg_pp0_iter1, p_Result_11_7_fu_349_p17, ap_block_pp0_stage1_01001, p_Result_19_7_fu_396_p17, ap_block_pp0_stage0_01001)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_01001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            iq_in8_din <= p_Result_19_7_fu_396_p17;
        elsif (((icmp_ln81_reg_438 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1_01001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1))) then 
            iq_in8_din <= p_Result_11_7_fu_349_p17;
        else 
            iq_in8_din <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    iq_in8_write_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_CS_fsm_pp0_stage1, icmp_ln81_reg_438, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0_11001, ap_block_pp0_stage1_11001)
    begin
        if ((((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)) or ((icmp_ln81_reg_438 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)))) then 
            iq_in8_write <= ap_const_logic_1;
        else 
            iq_in8_write <= ap_const_logic_0;
        end if; 
    end process;


    istream_V_TDATA_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, icmp_ln81_fu_329_p2, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage1, icmp_ln81_reg_438, istream_V_TVALID_int_regslice)
    begin
        if ((((icmp_ln81_reg_438 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            istream_V_TDATA_blk_n <= istream_V_TVALID_int_regslice;
        else 
            istream_V_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    istream_V_TREADY <= regslice_both_istream_V_U_ack_in;

    istream_V_TREADY_int_regslice_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, icmp_ln81_fu_329_p2, ap_CS_fsm_pp0_stage1, icmp_ln81_reg_438, ap_block_pp0_stage0_11001, ap_block_pp0_stage1_11001)
    begin
        if ((((icmp_ln81_reg_438 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            istream_V_TREADY_int_regslice <= ap_const_logic_1;
        else 
            istream_V_TREADY_int_regslice <= ap_const_logic_0;
        end if; 
    end process;

    p_Result_11_7_fu_349_p17 <= (((((((((((((((reg_303 & reg_299) & reg_295) & reg_291) & reg_287) & reg_283) & reg_279) & reg_275) & reg_271) & reg_267) & reg_263) & reg_259) & reg_255) & reg_251) & trunc_ln674_1_reg_447) & trunc_ln674_reg_442);
    p_Result_19_7_fu_396_p17 <= (((((((((((((((reg_303 & reg_299) & reg_295) & reg_291) & reg_287) & reg_283) & reg_279) & reg_275) & reg_271) & reg_267) & reg_263) & reg_259) & reg_255) & reg_251) & trunc_ln674_3_reg_462) & trunc_ln674_2_reg_457);

    qstream_V_TDATA_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, ap_block_pp0_stage0, icmp_ln81_fu_329_p2, ap_CS_fsm_pp0_stage1, ap_block_pp0_stage1, icmp_ln81_reg_438, qstream_V_TVALID_int_regslice)
    begin
        if ((((icmp_ln81_reg_438 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            qstream_V_TDATA_blk_n <= qstream_V_TVALID_int_regslice;
        else 
            qstream_V_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    qstream_V_TREADY <= regslice_both_qstream_V_U_ack_in;

    qstream_V_TREADY_int_regslice_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter0, icmp_ln81_fu_329_p2, ap_CS_fsm_pp0_stage1, icmp_ln81_reg_438, ap_block_pp0_stage0_11001, ap_block_pp0_stage1_11001)
    begin
        if ((((icmp_ln81_reg_438 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage1_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage1)) or ((icmp_ln81_fu_329_p2 = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0)))) then 
            qstream_V_TREADY_int_regslice <= ap_const_logic_1;
        else 
            qstream_V_TREADY_int_regslice <= ap_const_logic_0;
        end if; 
    end process;

    tmp_fu_319_p4 <= i_fu_82(30 downto 1);
    trunc_ln674_1_fu_339_p1 <= qstream_V_TDATA_int_regslice(16 - 1 downto 0);
    trunc_ln674_2_fu_384_p1 <= istream_V_TDATA_int_regslice(16 - 1 downto 0);
    trunc_ln674_3_fu_388_p1 <= qstream_V_TDATA_int_regslice(16 - 1 downto 0);
    trunc_ln674_fu_335_p1 <= istream_V_TDATA_int_regslice(16 - 1 downto 0);
    zext_ln81_fu_307_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(capturesize),31));
end behav;