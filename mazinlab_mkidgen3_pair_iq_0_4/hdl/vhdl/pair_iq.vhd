-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pair_iq is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    i_in_V_TDATA : IN STD_LOGIC_VECTOR (127 downto 0);
    i_in_V_TVALID : IN STD_LOGIC;
    i_in_V_TREADY : OUT STD_LOGIC;
    q_in_V_TDATA : IN STD_LOGIC_VECTOR (127 downto 0);
    q_in_V_TVALID : IN STD_LOGIC;
    q_in_V_TREADY : OUT STD_LOGIC;
    out_r_TDATA : OUT STD_LOGIC_VECTOR (255 downto 0);
    out_r_TVALID : OUT STD_LOGIC;
    out_r_TREADY : IN STD_LOGIC;
    out_r_TKEEP : OUT STD_LOGIC_VECTOR (31 downto 0);
    out_r_TSTRB : OUT STD_LOGIC_VECTOR (31 downto 0);
    out_r_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0) );
end;


architecture behav of pair_iq is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "pair_iq_pair_iq,hls_ip_2021_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu21dr-ffvd1156-1-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=0.907000,HLS_SYN_LAT=0,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=9,HLS_SYN_LUT=55,HLS_VERSION=2021_1}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_FFFFFFFF : STD_LOGIC_VECTOR (31 downto 0) := "11111111111111111111111111111111";
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
    constant ap_const_lv8_FF : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
    constant ap_const_lv8_1 : STD_LOGIC_VECTOR (7 downto 0) := "00000001";
    constant ap_const_boolean_1 : BOOLEAN := true;

    signal ap_rst_n_inv : STD_LOGIC;
    signal group_r : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal i_in_V_TDATA_blk_n : STD_LOGIC;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal q_in_V_TDATA_blk_n : STD_LOGIC;
    signal out_r_TDATA_blk_n : STD_LOGIC;
    signal add_ln870_fu_304_p2 : STD_LOGIC_VECTOR (7 downto 0);
    signal ap_block_state1 : BOOLEAN;
    signal p_Result_13_fu_246_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_12_fu_236_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_11_fu_226_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_10_fu_216_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_2_fu_206_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_9_fu_196_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_7_fu_186_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_5_fu_176_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_3_fu_166_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_1_fu_156_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_s_fu_146_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_8_fu_136_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_6_fu_126_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal p_Result_4_fu_116_p4 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_1_fu_112_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal trunc_ln674_fu_108_p1 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;


begin




    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((not(((i_in_V_TVALID = ap_const_logic_0) or (out_r_TREADY = ap_const_logic_0) or (q_in_V_TVALID = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                group_r <= add_ln870_fu_304_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (i_in_V_TVALID, q_in_V_TVALID, out_r_TREADY, ap_CS_fsm, ap_CS_fsm_state1)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    add_ln870_fu_304_p2 <= std_logic_vector(unsigned(group_r) + unsigned(ap_const_lv8_1));
    ap_CS_fsm_state1 <= ap_CS_fsm(0);

    ap_ST_fsm_state1_blk_assign_proc : process(i_in_V_TVALID, q_in_V_TVALID, out_r_TREADY)
    begin
        if (((i_in_V_TVALID = ap_const_logic_0) or (out_r_TREADY = ap_const_logic_0) or (q_in_V_TVALID = ap_const_logic_0))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(i_in_V_TVALID, q_in_V_TVALID, out_r_TREADY)
    begin
                ap_block_state1 <= ((i_in_V_TVALID = ap_const_logic_0) or (out_r_TREADY = ap_const_logic_0) or (q_in_V_TVALID = ap_const_logic_0));
    end process;


    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;


    i_in_V_TDATA_blk_n_assign_proc : process(i_in_V_TVALID, ap_CS_fsm_state1)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state1)) then 
            i_in_V_TDATA_blk_n <= i_in_V_TVALID;
        else 
            i_in_V_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    i_in_V_TREADY_assign_proc : process(i_in_V_TVALID, q_in_V_TVALID, out_r_TREADY, ap_CS_fsm_state1)
    begin
        if ((not(((i_in_V_TVALID = ap_const_logic_0) or (out_r_TREADY = ap_const_logic_0) or (q_in_V_TVALID = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            i_in_V_TREADY <= ap_const_logic_1;
        else 
            i_in_V_TREADY <= ap_const_logic_0;
        end if; 
    end process;

    out_r_TDATA <= (((((((((((((((p_Result_13_fu_246_p4 & p_Result_12_fu_236_p4) & p_Result_11_fu_226_p4) & p_Result_10_fu_216_p4) & p_Result_2_fu_206_p4) & p_Result_9_fu_196_p4) & p_Result_7_fu_186_p4) & p_Result_5_fu_176_p4) & p_Result_3_fu_166_p4) & p_Result_1_fu_156_p4) & p_Result_s_fu_146_p4) & p_Result_8_fu_136_p4) & p_Result_6_fu_126_p4) & p_Result_4_fu_116_p4) & trunc_ln674_1_fu_112_p1) & trunc_ln674_fu_108_p1);

    out_r_TDATA_blk_n_assign_proc : process(out_r_TREADY, ap_CS_fsm_state1)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state1)) then 
            out_r_TDATA_blk_n <= out_r_TREADY;
        else 
            out_r_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    out_r_TKEEP <= ap_const_lv32_FFFFFFFF;
    out_r_TLAST <= "1" when (group_r = ap_const_lv8_FF) else "0";
    out_r_TSTRB <= ap_const_lv32_0;

    out_r_TVALID_assign_proc : process(i_in_V_TVALID, q_in_V_TVALID, out_r_TREADY, ap_CS_fsm_state1)
    begin
        if ((not(((i_in_V_TVALID = ap_const_logic_0) or (out_r_TREADY = ap_const_logic_0) or (q_in_V_TVALID = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            out_r_TVALID <= ap_const_logic_1;
        else 
            out_r_TVALID <= ap_const_logic_0;
        end if; 
    end process;

    p_Result_10_fu_216_p4 <= i_in_V_TDATA(111 downto 96);
    p_Result_11_fu_226_p4 <= q_in_V_TDATA(111 downto 96);
    p_Result_12_fu_236_p4 <= i_in_V_TDATA(127 downto 112);
    p_Result_13_fu_246_p4 <= q_in_V_TDATA(127 downto 112);
    p_Result_1_fu_156_p4 <= i_in_V_TDATA(63 downto 48);
    p_Result_2_fu_206_p4 <= q_in_V_TDATA(95 downto 80);
    p_Result_3_fu_166_p4 <= q_in_V_TDATA(63 downto 48);
    p_Result_4_fu_116_p4 <= i_in_V_TDATA(31 downto 16);
    p_Result_5_fu_176_p4 <= i_in_V_TDATA(79 downto 64);
    p_Result_6_fu_126_p4 <= q_in_V_TDATA(31 downto 16);
    p_Result_7_fu_186_p4 <= q_in_V_TDATA(79 downto 64);
    p_Result_8_fu_136_p4 <= i_in_V_TDATA(47 downto 32);
    p_Result_9_fu_196_p4 <= i_in_V_TDATA(95 downto 80);
    p_Result_s_fu_146_p4 <= q_in_V_TDATA(47 downto 32);

    q_in_V_TDATA_blk_n_assign_proc : process(q_in_V_TVALID, ap_CS_fsm_state1)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state1)) then 
            q_in_V_TDATA_blk_n <= q_in_V_TVALID;
        else 
            q_in_V_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    q_in_V_TREADY_assign_proc : process(i_in_V_TVALID, q_in_V_TVALID, out_r_TREADY, ap_CS_fsm_state1)
    begin
        if ((not(((i_in_V_TVALID = ap_const_logic_0) or (out_r_TREADY = ap_const_logic_0) or (q_in_V_TVALID = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            q_in_V_TREADY <= ap_const_logic_1;
        else 
            q_in_V_TREADY <= ap_const_logic_0;
        end if; 
    end process;

    trunc_ln674_1_fu_112_p1 <= q_in_V_TDATA(16 - 1 downto 0);
    trunc_ln674_fu_108_p1 <= i_in_V_TDATA(16 - 1 downto 0);
end behav;
