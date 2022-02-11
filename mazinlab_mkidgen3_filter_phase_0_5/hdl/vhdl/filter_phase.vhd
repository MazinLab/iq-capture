-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity filter_phase is
generic (
    C_S_AXI_CONTROL_ADDR_WIDTH : INTEGER := 6;
    C_S_AXI_CONTROL_DATA_WIDTH : INTEGER := 32 );
port (
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    instream_TDATA : IN STD_LOGIC_VECTOR (63 downto 0);
    instream_TVALID : IN STD_LOGIC;
    instream_TREADY : OUT STD_LOGIC;
    instream_TKEEP : IN STD_LOGIC_VECTOR (7 downto 0);
    instream_TSTRB : IN STD_LOGIC_VECTOR (7 downto 0);
    instream_TUSER : IN STD_LOGIC_VECTOR (15 downto 0);
    instream_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
    outstream_TDATA : OUT STD_LOGIC_VECTOR (255 downto 0);
    outstream_TVALID : OUT STD_LOGIC;
    outstream_TREADY : IN STD_LOGIC;
    outstream_TKEEP : OUT STD_LOGIC_VECTOR (31 downto 0);
    outstream_TSTRB : OUT STD_LOGIC_VECTOR (31 downto 0);
    outstream_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0);
    s_axi_control_AWVALID : IN STD_LOGIC;
    s_axi_control_AWREADY : OUT STD_LOGIC;
    s_axi_control_AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_ADDR_WIDTH-1 downto 0);
    s_axi_control_WVALID : IN STD_LOGIC;
    s_axi_control_WREADY : OUT STD_LOGIC;
    s_axi_control_WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_DATA_WIDTH-1 downto 0);
    s_axi_control_WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_DATA_WIDTH/8-1 downto 0);
    s_axi_control_ARVALID : IN STD_LOGIC;
    s_axi_control_ARREADY : OUT STD_LOGIC;
    s_axi_control_ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_ADDR_WIDTH-1 downto 0);
    s_axi_control_RVALID : OUT STD_LOGIC;
    s_axi_control_RREADY : IN STD_LOGIC;
    s_axi_control_RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_CONTROL_DATA_WIDTH-1 downto 0);
    s_axi_control_RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
    s_axi_control_BVALID : OUT STD_LOGIC;
    s_axi_control_BREADY : IN STD_LOGIC;
    s_axi_control_BRESP : OUT STD_LOGIC_VECTOR (1 downto 0) );
end;


architecture behav of filter_phase is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "filter_phase_filter_phase,hls_ip_2021_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu21dr-ffvd1156-1-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=1.000000,HLS_SYN_LAT=3,HLS_SYN_TPT=4,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=390,HLS_SYN_LUT=380,HLS_VERSION=2021_1}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (3 downto 0) := "0100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (3 downto 0) := "1000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant C_S_AXI_DATA_WIDTH : INTEGER range 63 downto 0 := 20;
    constant ap_const_lv32_FFFFFFFF : STD_LOGIC_VECTOR (31 downto 0) := "11111111111111111111111111111111";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";

    signal ap_rst_n_inv : STD_LOGIC;
    signal keep : STD_LOGIC_VECTOR (127 downto 0);
    signal lastgrp : STD_LOGIC_VECTOR (6 downto 0);
    signal instream_TDATA_blk_n : STD_LOGIC;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal p_aligne_reg_180 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal outstream_TDATA_blk_n : STD_LOGIC;
    signal p_keep_reg_189 : STD_LOGIC_VECTOR (0 downto 0);
    signal lastgrp_read_reg_170 : STD_LOGIC_VECTOR (6 downto 0);
    signal tmp_3_reg_175 : STD_LOGIC_VECTOR (63 downto 0);
    signal p_aligne_fu_139_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_V_reg_184 : STD_LOGIC_VECTOR (6 downto 0);
    signal p_keep_fetch_keep_fu_120_ap_return : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_5_reg_193 : STD_LOGIC_VECTOR (63 downto 0);
    signal tmp_last_V_fu_156_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_last_V_reg_198 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_6_reg_203 : STD_LOGIC_VECTOR (63 downto 0);
    signal p_keep_fetch_keep_fu_120_ap_ready : STD_LOGIC;
    signal p_keep_fetch_keep_fu_120_grp : STD_LOGIC_VECTOR (6 downto 0);
    signal ap_block_state2 : BOOLEAN;
    signal ap_block_state3 : BOOLEAN;
    signal ap_predicate_op44_write_state4 : BOOLEAN;
    signal ap_block_state4 : BOOLEAN;
    signal ap_block_state4_io : BOOLEAN;
    signal trunc_ln674_fu_135_p1 : STD_LOGIC_VECTOR (1 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component filter_phase_fetch_keep IS
    port (
        ap_ready : OUT STD_LOGIC;
        keep : IN STD_LOGIC_VECTOR (127 downto 0);
        grp : IN STD_LOGIC_VECTOR (6 downto 0);
        ap_return : OUT STD_LOGIC_VECTOR (0 downto 0) );
    end component;


    component filter_phase_control_s_axi IS
    generic (
        C_S_AXI_ADDR_WIDTH : INTEGER;
        C_S_AXI_DATA_WIDTH : INTEGER );
    port (
        AWVALID : IN STD_LOGIC;
        AWREADY : OUT STD_LOGIC;
        AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_ADDR_WIDTH-1 downto 0);
        WVALID : IN STD_LOGIC;
        WREADY : OUT STD_LOGIC;
        WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
        WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH/8-1 downto 0);
        ARVALID : IN STD_LOGIC;
        ARREADY : OUT STD_LOGIC;
        ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_ADDR_WIDTH-1 downto 0);
        RVALID : OUT STD_LOGIC;
        RREADY : IN STD_LOGIC;
        RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
        RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        BVALID : OUT STD_LOGIC;
        BREADY : IN STD_LOGIC;
        BRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        ACLK : IN STD_LOGIC;
        ARESET : IN STD_LOGIC;
        ACLK_EN : IN STD_LOGIC;
        keep : OUT STD_LOGIC_VECTOR (127 downto 0);
        lastgrp : OUT STD_LOGIC_VECTOR (6 downto 0) );
    end component;



begin
    p_keep_fetch_keep_fu_120 : component filter_phase_fetch_keep
    port map (
        ap_ready => p_keep_fetch_keep_fu_120_ap_ready,
        keep => keep,
        grp => p_keep_fetch_keep_fu_120_grp,
        ap_return => p_keep_fetch_keep_fu_120_ap_return);

    control_s_axi_U : component filter_phase_control_s_axi
    generic map (
        C_S_AXI_ADDR_WIDTH => C_S_AXI_CONTROL_ADDR_WIDTH,
        C_S_AXI_DATA_WIDTH => C_S_AXI_CONTROL_DATA_WIDTH)
    port map (
        AWVALID => s_axi_control_AWVALID,
        AWREADY => s_axi_control_AWREADY,
        AWADDR => s_axi_control_AWADDR,
        WVALID => s_axi_control_WVALID,
        WREADY => s_axi_control_WREADY,
        WDATA => s_axi_control_WDATA,
        WSTRB => s_axi_control_WSTRB,
        ARVALID => s_axi_control_ARVALID,
        ARREADY => s_axi_control_ARREADY,
        ARADDR => s_axi_control_ARADDR,
        RVALID => s_axi_control_RVALID,
        RREADY => s_axi_control_RREADY,
        RDATA => s_axi_control_RDATA,
        RRESP => s_axi_control_RRESP,
        BVALID => s_axi_control_BVALID,
        BREADY => s_axi_control_BREADY,
        BRESP => s_axi_control_BRESP,
        ACLK => ap_clk,
        ARESET => ap_rst_n_inv,
        ACLK_EN => ap_const_logic_1,
        keep => keep,
        lastgrp => lastgrp);





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
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                grp_V_reg_184 <= instream_TUSER(8 downto 2);
                lastgrp_read_reg_170 <= lastgrp;
                p_aligne_reg_180 <= p_aligne_fu_139_p2;
                p_keep_reg_189 <= p_keep_fetch_keep_fu_120_ap_return;
                tmp_3_reg_175 <= instream_TDATA;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((p_aligne_reg_180 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                tmp_5_reg_193 <= instream_TDATA;
                tmp_last_V_reg_198 <= tmp_last_V_fu_156_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((p_aligne_reg_180 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3))) then
                tmp_6_reg_203 <= instream_TDATA;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (instream_TVALID, outstream_TREADY, ap_CS_fsm, ap_CS_fsm_state1, ap_CS_fsm_state2, p_aligne_reg_180, ap_CS_fsm_state3, ap_CS_fsm_state4, ap_predicate_op44_write_state4, ap_block_state4_io)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state1) and (instream_TVALID = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if ((not(((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                    ap_NS_fsm <= ap_ST_fsm_state3;
                else
                    ap_NS_fsm <= ap_ST_fsm_state2;
                end if;
            when ap_ST_fsm_state3 => 
                if ((not(((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state3))) then
                    ap_NS_fsm <= ap_ST_fsm_state4;
                else
                    ap_NS_fsm <= ap_ST_fsm_state3;
                end if;
            when ap_ST_fsm_state4 => 
                if ((not(((ap_const_boolean_1 = ap_block_state4_io) or ((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0)) or ((outstream_TREADY = ap_const_logic_0) and (ap_predicate_op44_write_state4 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state4))) then
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

    ap_ST_fsm_state1_blk_assign_proc : process(instream_TVALID)
    begin
        if ((instream_TVALID = ap_const_logic_0)) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_ST_fsm_state2_blk_assign_proc : process(instream_TVALID, p_aligne_reg_180)
    begin
        if (((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0))) then 
            ap_ST_fsm_state2_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state2_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_ST_fsm_state3_blk_assign_proc : process(instream_TVALID, p_aligne_reg_180)
    begin
        if (((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0))) then 
            ap_ST_fsm_state3_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state3_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_ST_fsm_state4_blk_assign_proc : process(instream_TVALID, outstream_TREADY, p_aligne_reg_180, ap_predicate_op44_write_state4, ap_block_state4_io)
    begin
        if (((ap_const_boolean_1 = ap_block_state4_io) or ((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0)) or ((outstream_TREADY = ap_const_logic_0) and (ap_predicate_op44_write_state4 = ap_const_boolean_1)))) then 
            ap_ST_fsm_state4_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state4_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state2_assign_proc : process(instream_TVALID, p_aligne_reg_180)
    begin
                ap_block_state2 <= ((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0));
    end process;


    ap_block_state3_assign_proc : process(instream_TVALID, p_aligne_reg_180)
    begin
                ap_block_state3 <= ((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0));
    end process;


    ap_block_state4_assign_proc : process(instream_TVALID, outstream_TREADY, p_aligne_reg_180, ap_predicate_op44_write_state4)
    begin
                ap_block_state4 <= (((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0)) or ((outstream_TREADY = ap_const_logic_0) and (ap_predicate_op44_write_state4 = ap_const_boolean_1)));
    end process;


    ap_block_state4_io_assign_proc : process(outstream_TREADY, ap_predicate_op44_write_state4)
    begin
                ap_block_state4_io <= ((outstream_TREADY = ap_const_logic_0) and (ap_predicate_op44_write_state4 = ap_const_boolean_1));
    end process;


    ap_predicate_op44_write_state4_assign_proc : process(p_aligne_reg_180, p_keep_reg_189)
    begin
                ap_predicate_op44_write_state4 <= ((p_keep_reg_189 = ap_const_lv1_1) and (p_aligne_reg_180 = ap_const_lv1_1));
    end process;


    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;


    instream_TDATA_blk_n_assign_proc : process(instream_TVALID, ap_CS_fsm_state1, ap_CS_fsm_state2, p_aligne_reg_180, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) or ((p_aligne_reg_180 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state4)) or ((p_aligne_reg_180 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3)) or ((p_aligne_reg_180 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2)))) then 
            instream_TDATA_blk_n <= instream_TVALID;
        else 
            instream_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    instream_TREADY_assign_proc : process(instream_TVALID, outstream_TREADY, ap_CS_fsm_state1, ap_CS_fsm_state2, p_aligne_reg_180, ap_CS_fsm_state3, ap_CS_fsm_state4, ap_predicate_op44_write_state4, ap_block_state4_io)
    begin
        if ((((ap_const_logic_1 = ap_CS_fsm_state1) and (instream_TVALID = ap_const_logic_1)) or (not(((ap_const_boolean_1 = ap_block_state4_io) or ((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0)) or ((outstream_TREADY = ap_const_logic_0) and (ap_predicate_op44_write_state4 = ap_const_boolean_1)))) and (p_aligne_reg_180 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state4)) or (not(((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0))) and (p_aligne_reg_180 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state3)) or (not(((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0))) and (p_aligne_reg_180 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2)))) then 
            instream_TREADY <= ap_const_logic_1;
        else 
            instream_TREADY <= ap_const_logic_0;
        end if; 
    end process;

    outstream_TDATA <= (((instream_TDATA & tmp_6_reg_203) & tmp_5_reg_193) & tmp_3_reg_175);

    outstream_TDATA_blk_n_assign_proc : process(outstream_TREADY, p_aligne_reg_180, ap_CS_fsm_state4, p_keep_reg_189)
    begin
        if (((p_keep_reg_189 = ap_const_lv1_1) and (p_aligne_reg_180 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then 
            outstream_TDATA_blk_n <= outstream_TREADY;
        else 
            outstream_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    outstream_TKEEP <= ap_const_lv32_FFFFFFFF;
    outstream_TLAST <= tmp_last_V_reg_198;
    outstream_TSTRB <= ap_const_lv32_0;

    outstream_TVALID_assign_proc : process(instream_TVALID, outstream_TREADY, p_aligne_reg_180, ap_CS_fsm_state4, ap_predicate_op44_write_state4, ap_block_state4_io)
    begin
        if ((not(((ap_const_boolean_1 = ap_block_state4_io) or ((p_aligne_reg_180 = ap_const_lv1_1) and (instream_TVALID = ap_const_logic_0)) or ((outstream_TREADY = ap_const_logic_0) and (ap_predicate_op44_write_state4 = ap_const_boolean_1)))) and (ap_const_logic_1 = ap_CS_fsm_state4) and (ap_predicate_op44_write_state4 = ap_const_boolean_1))) then 
            outstream_TVALID <= ap_const_logic_1;
        else 
            outstream_TVALID <= ap_const_logic_0;
        end if; 
    end process;

    p_aligne_fu_139_p2 <= "1" when (trunc_ln674_fu_135_p1 = ap_const_lv2_0) else "0";
    p_keep_fetch_keep_fu_120_grp <= instream_TUSER(8 downto 2);
    tmp_last_V_fu_156_p2 <= "1" when (grp_V_reg_184 = lastgrp_read_reg_170) else "0";
    trunc_ln674_fu_135_p1 <= instream_TUSER(2 - 1 downto 0);
end behav;
