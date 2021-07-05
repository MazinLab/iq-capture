-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity iq_capture_put_data_csize_ap_uint_256_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    toout17_dout : IN STD_LOGIC_VECTOR (255 downto 0);
    toout17_empty_n : IN STD_LOGIC;
    toout17_read : OUT STD_LOGIC;
    p_read : IN STD_LOGIC_VECTOR (26 downto 0);
    m_axi_gmem_AWVALID : OUT STD_LOGIC;
    m_axi_gmem_AWREADY : IN STD_LOGIC;
    m_axi_gmem_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_gmem_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_gmem_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_gmem_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_gmem_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_gmem_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_gmem_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_gmem_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_gmem_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_gmem_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_gmem_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_gmem_WVALID : OUT STD_LOGIC;
    m_axi_gmem_WREADY : IN STD_LOGIC;
    m_axi_gmem_WDATA : OUT STD_LOGIC_VECTOR (255 downto 0);
    m_axi_gmem_WSTRB : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_gmem_WLAST : OUT STD_LOGIC;
    m_axi_gmem_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_gmem_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_gmem_ARVALID : OUT STD_LOGIC;
    m_axi_gmem_ARREADY : IN STD_LOGIC;
    m_axi_gmem_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
    m_axi_gmem_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_gmem_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
    m_axi_gmem_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_gmem_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_gmem_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
    m_axi_gmem_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_gmem_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
    m_axi_gmem_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_gmem_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
    m_axi_gmem_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
    m_axi_gmem_RVALID : IN STD_LOGIC;
    m_axi_gmem_RREADY : OUT STD_LOGIC;
    m_axi_gmem_RDATA : IN STD_LOGIC_VECTOR (255 downto 0);
    m_axi_gmem_RLAST : IN STD_LOGIC;
    m_axi_gmem_RID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_gmem_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_gmem_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_gmem_BVALID : IN STD_LOGIC;
    m_axi_gmem_BREADY : OUT STD_LOGIC;
    m_axi_gmem_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
    m_axi_gmem_BID : IN STD_LOGIC_VECTOR (0 downto 0);
    m_axi_gmem_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
    p_read1 : IN STD_LOGIC_VECTOR (63 downto 0) );
end;


architecture behav of iq_capture_put_data_csize_ap_uint_256_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (8 downto 0) := "000000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (8 downto 0) := "000000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (8 downto 0) := "000000100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (8 downto 0) := "000001000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (8 downto 0) := "000010000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (8 downto 0) := "000100000";
    constant ap_ST_fsm_state7 : STD_LOGIC_VECTOR (8 downto 0) := "001000000";
    constant ap_ST_fsm_state8 : STD_LOGIC_VECTOR (8 downto 0) := "010000000";
    constant ap_ST_fsm_state9 : STD_LOGIC_VECTOR (8 downto 0) := "100000000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv3_0 : STD_LOGIC_VECTOR (2 downto 0) := "000";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv27_0 : STD_LOGIC_VECTOR (26 downto 0) := "000000000000000000000000000";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";
    constant ap_const_lv32_3F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000111111";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv256_lc_1 : STD_LOGIC_VECTOR (255 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

attribute shreg_extract : string;
    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (8 downto 0) := "000000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal gmem_blk_n_AW : STD_LOGIC;
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal icmp_ln1057_reg_118 : STD_LOGIC_VECTOR (0 downto 0);
    signal gmem_blk_n_B : STD_LOGIC;
    signal ap_CS_fsm_state9 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state9 : signal is "none";
    signal icmp_ln1057_fu_81_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln_fu_87_p4 : STD_LOGIC_VECTOR (58 downto 0);
    signal trunc_ln_reg_122 : STD_LOGIC_VECTOR (58 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_start : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_done : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_idle : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_ready : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_toout17_read : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWVALID : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWID : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WVALID : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WDATA : STD_LOGIC_VECTOR (255 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WSTRB : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WLAST : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WID : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARVALID : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARADDR : STD_LOGIC_VECTOR (63 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARID : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARLEN : STD_LOGIC_VECTOR (31 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARSIZE : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARBURST : STD_LOGIC_VECTOR (1 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARLOCK : STD_LOGIC_VECTOR (1 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARCACHE : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARPROT : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARQOS : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARREGION : STD_LOGIC_VECTOR (3 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARUSER : STD_LOGIC_VECTOR (0 downto 0);
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_RREADY : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_BREADY : STD_LOGIC;
    signal grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal sext_ln57_fu_97_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_block_state2_io : BOOLEAN;
    signal zext_ln57_fu_108_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal ap_block_state9 : BOOLEAN;
    signal ap_block_state1 : BOOLEAN;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (8 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal ap_ST_fsm_state5_blk : STD_LOGIC;
    signal ap_ST_fsm_state6_blk : STD_LOGIC;
    signal ap_ST_fsm_state7_blk : STD_LOGIC;
    signal ap_ST_fsm_state8_blk : STD_LOGIC;
    signal ap_ST_fsm_state9_blk : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component iq_capture_put_data_csize_ap_uint_256_Pipeline_write IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        toout17_dout : IN STD_LOGIC_VECTOR (255 downto 0);
        toout17_empty_n : IN STD_LOGIC;
        toout17_read : OUT STD_LOGIC;
        m_axi_gmem_AWVALID : OUT STD_LOGIC;
        m_axi_gmem_AWREADY : IN STD_LOGIC;
        m_axi_gmem_AWADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
        m_axi_gmem_AWID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_gmem_AWLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_gmem_AWSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_gmem_AWBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_gmem_AWLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_gmem_AWCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_gmem_AWPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_gmem_AWQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_gmem_AWREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_gmem_AWUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_gmem_WVALID : OUT STD_LOGIC;
        m_axi_gmem_WREADY : IN STD_LOGIC;
        m_axi_gmem_WDATA : OUT STD_LOGIC_VECTOR (255 downto 0);
        m_axi_gmem_WSTRB : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_gmem_WLAST : OUT STD_LOGIC;
        m_axi_gmem_WID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_gmem_WUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_gmem_ARVALID : OUT STD_LOGIC;
        m_axi_gmem_ARREADY : IN STD_LOGIC;
        m_axi_gmem_ARADDR : OUT STD_LOGIC_VECTOR (63 downto 0);
        m_axi_gmem_ARID : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_gmem_ARLEN : OUT STD_LOGIC_VECTOR (31 downto 0);
        m_axi_gmem_ARSIZE : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_gmem_ARBURST : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_gmem_ARLOCK : OUT STD_LOGIC_VECTOR (1 downto 0);
        m_axi_gmem_ARCACHE : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_gmem_ARPROT : OUT STD_LOGIC_VECTOR (2 downto 0);
        m_axi_gmem_ARQOS : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_gmem_ARREGION : OUT STD_LOGIC_VECTOR (3 downto 0);
        m_axi_gmem_ARUSER : OUT STD_LOGIC_VECTOR (0 downto 0);
        m_axi_gmem_RVALID : IN STD_LOGIC;
        m_axi_gmem_RREADY : OUT STD_LOGIC;
        m_axi_gmem_RDATA : IN STD_LOGIC_VECTOR (255 downto 0);
        m_axi_gmem_RLAST : IN STD_LOGIC;
        m_axi_gmem_RID : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_gmem_RUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_gmem_RRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        m_axi_gmem_BVALID : IN STD_LOGIC;
        m_axi_gmem_BREADY : OUT STD_LOGIC;
        m_axi_gmem_BRESP : IN STD_LOGIC_VECTOR (1 downto 0);
        m_axi_gmem_BID : IN STD_LOGIC_VECTOR (0 downto 0);
        m_axi_gmem_BUSER : IN STD_LOGIC_VECTOR (0 downto 0);
        sext_ln57 : IN STD_LOGIC_VECTOR (58 downto 0);
        p_read : IN STD_LOGIC_VECTOR (26 downto 0) );
    end component;



begin
    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71 : component iq_capture_put_data_csize_ap_uint_256_Pipeline_write
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_start,
        ap_done => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_done,
        ap_idle => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_idle,
        ap_ready => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_ready,
        toout17_dout => toout17_dout,
        toout17_empty_n => toout17_empty_n,
        toout17_read => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_toout17_read,
        m_axi_gmem_AWVALID => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWVALID,
        m_axi_gmem_AWREADY => m_axi_gmem_AWREADY,
        m_axi_gmem_AWADDR => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWADDR,
        m_axi_gmem_AWID => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWID,
        m_axi_gmem_AWLEN => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWLEN,
        m_axi_gmem_AWSIZE => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWSIZE,
        m_axi_gmem_AWBURST => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWBURST,
        m_axi_gmem_AWLOCK => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWLOCK,
        m_axi_gmem_AWCACHE => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWCACHE,
        m_axi_gmem_AWPROT => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWPROT,
        m_axi_gmem_AWQOS => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWQOS,
        m_axi_gmem_AWREGION => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWREGION,
        m_axi_gmem_AWUSER => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWUSER,
        m_axi_gmem_WVALID => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WVALID,
        m_axi_gmem_WREADY => m_axi_gmem_WREADY,
        m_axi_gmem_WDATA => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WDATA,
        m_axi_gmem_WSTRB => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WSTRB,
        m_axi_gmem_WLAST => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WLAST,
        m_axi_gmem_WID => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WID,
        m_axi_gmem_WUSER => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WUSER,
        m_axi_gmem_ARVALID => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARVALID,
        m_axi_gmem_ARREADY => ap_const_logic_0,
        m_axi_gmem_ARADDR => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARADDR,
        m_axi_gmem_ARID => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARID,
        m_axi_gmem_ARLEN => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARLEN,
        m_axi_gmem_ARSIZE => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARSIZE,
        m_axi_gmem_ARBURST => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARBURST,
        m_axi_gmem_ARLOCK => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARLOCK,
        m_axi_gmem_ARCACHE => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARCACHE,
        m_axi_gmem_ARPROT => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARPROT,
        m_axi_gmem_ARQOS => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARQOS,
        m_axi_gmem_ARREGION => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARREGION,
        m_axi_gmem_ARUSER => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_ARUSER,
        m_axi_gmem_RVALID => ap_const_logic_0,
        m_axi_gmem_RREADY => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_RREADY,
        m_axi_gmem_RDATA => ap_const_lv256_lc_1,
        m_axi_gmem_RLAST => ap_const_logic_0,
        m_axi_gmem_RID => ap_const_lv1_0,
        m_axi_gmem_RUSER => ap_const_lv1_0,
        m_axi_gmem_RRESP => ap_const_lv2_0,
        m_axi_gmem_BVALID => m_axi_gmem_BVALID,
        m_axi_gmem_BREADY => grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_BREADY,
        m_axi_gmem_BRESP => m_axi_gmem_BRESP,
        m_axi_gmem_BID => m_axi_gmem_BID,
        m_axi_gmem_BUSER => m_axi_gmem_BUSER,
        sext_ln57 => trunc_ln_reg_122,
        p_read => p_read);





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
                elsif ((not(((icmp_ln1057_reg_118 = ap_const_lv1_0) and (m_axi_gmem_BVALID = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state9))) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_start_reg <= ap_const_logic_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
                    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_ready = ap_const_logic_1)) then 
                    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                icmp_ln1057_reg_118 <= icmp_ln1057_fu_81_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((icmp_ln1057_reg_118 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then
                trunc_ln_reg_122 <= p_read1(63 downto 5);
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, m_axi_gmem_BVALID, ap_CS_fsm_state2, icmp_ln1057_reg_118, ap_CS_fsm_state9, grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_done, ap_CS_fsm_state4, ap_block_state2_io)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                if (((icmp_ln1057_reg_118 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state2) and (ap_const_boolean_0 = ap_block_state2_io))) then
                    ap_NS_fsm <= ap_ST_fsm_state9;
                elsif (((icmp_ln1057_reg_118 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2) and (ap_const_boolean_0 = ap_block_state2_io))) then
                    ap_NS_fsm <= ap_ST_fsm_state3;
                else
                    ap_NS_fsm <= ap_ST_fsm_state2;
                end if;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state4;
            when ap_ST_fsm_state4 => 
                if (((ap_const_logic_1 = ap_CS_fsm_state4) and (grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_done = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state5;
                else
                    ap_NS_fsm <= ap_ST_fsm_state4;
                end if;
            when ap_ST_fsm_state5 => 
                ap_NS_fsm <= ap_ST_fsm_state6;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when ap_ST_fsm_state7 => 
                ap_NS_fsm <= ap_ST_fsm_state8;
            when ap_ST_fsm_state8 => 
                ap_NS_fsm <= ap_ST_fsm_state9;
            when ap_ST_fsm_state9 => 
                if ((not(((icmp_ln1057_reg_118 = ap_const_lv1_0) and (m_axi_gmem_BVALID = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state9))) then
                    ap_NS_fsm <= ap_ST_fsm_state1;
                else
                    ap_NS_fsm <= ap_ST_fsm_state9;
                end if;
            when others =>  
                ap_NS_fsm <= "XXXXXXXXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
    ap_CS_fsm_state9 <= ap_CS_fsm(8);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start, ap_done_reg)
    begin
        if (((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0))) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_ST_fsm_state2_blk_assign_proc : process(ap_block_state2_io)
    begin
        if ((ap_const_boolean_1 = ap_block_state2_io)) then 
            ap_ST_fsm_state2_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state2_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state3_blk <= ap_const_logic_0;

    ap_ST_fsm_state4_blk_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_done)
    begin
        if ((grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state4_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state4_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state5_blk <= ap_const_logic_0;
    ap_ST_fsm_state6_blk <= ap_const_logic_0;
    ap_ST_fsm_state7_blk <= ap_const_logic_0;
    ap_ST_fsm_state8_blk <= ap_const_logic_0;

    ap_ST_fsm_state9_blk_assign_proc : process(m_axi_gmem_BVALID, icmp_ln1057_reg_118)
    begin
        if (((icmp_ln1057_reg_118 = ap_const_lv1_0) and (m_axi_gmem_BVALID = ap_const_logic_0))) then 
            ap_ST_fsm_state9_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state9_blk <= ap_const_logic_0;
        end if; 
    end process;


    ap_block_state1_assign_proc : process(ap_start, ap_done_reg)
    begin
                ap_block_state1 <= ((ap_done_reg = ap_const_logic_1) or (ap_start = ap_const_logic_0));
    end process;


    ap_block_state2_io_assign_proc : process(m_axi_gmem_AWREADY, icmp_ln1057_reg_118)
    begin
                ap_block_state2_io <= ((icmp_ln1057_reg_118 = ap_const_lv1_0) and (m_axi_gmem_AWREADY = ap_const_logic_0));
    end process;


    ap_block_state9_assign_proc : process(m_axi_gmem_BVALID, icmp_ln1057_reg_118)
    begin
                ap_block_state9 <= ((icmp_ln1057_reg_118 = ap_const_lv1_0) and (m_axi_gmem_BVALID = ap_const_logic_0));
    end process;


    ap_done_assign_proc : process(ap_done_reg, m_axi_gmem_BVALID, icmp_ln1057_reg_118, ap_CS_fsm_state9)
    begin
        if ((not(((icmp_ln1057_reg_118 = ap_const_lv1_0) and (m_axi_gmem_BVALID = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state9))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(m_axi_gmem_BVALID, icmp_ln1057_reg_118, ap_CS_fsm_state9)
    begin
        if ((not(((icmp_ln1057_reg_118 = ap_const_lv1_0) and (m_axi_gmem_BVALID = ap_const_logic_0))) and (ap_const_logic_1 = ap_CS_fsm_state9))) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    gmem_blk_n_AW_assign_proc : process(m_axi_gmem_AWREADY, ap_CS_fsm_state2, icmp_ln1057_reg_118)
    begin
        if (((icmp_ln1057_reg_118 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2))) then 
            gmem_blk_n_AW <= m_axi_gmem_AWREADY;
        else 
            gmem_blk_n_AW <= ap_const_logic_1;
        end if; 
    end process;


    gmem_blk_n_B_assign_proc : process(m_axi_gmem_BVALID, icmp_ln1057_reg_118, ap_CS_fsm_state9)
    begin
        if (((icmp_ln1057_reg_118 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state9))) then 
            gmem_blk_n_B <= m_axi_gmem_BVALID;
        else 
            gmem_blk_n_B <= ap_const_logic_1;
        end if; 
    end process;

    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_start <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_ap_start_reg;
    icmp_ln1057_fu_81_p2 <= "1" when (p_read = ap_const_lv27_0) else "0";
    m_axi_gmem_ARADDR <= ap_const_lv64_0;
    m_axi_gmem_ARBURST <= ap_const_lv2_0;
    m_axi_gmem_ARCACHE <= ap_const_lv4_0;
    m_axi_gmem_ARID <= ap_const_lv1_0;
    m_axi_gmem_ARLEN <= ap_const_lv32_0;
    m_axi_gmem_ARLOCK <= ap_const_lv2_0;
    m_axi_gmem_ARPROT <= ap_const_lv3_0;
    m_axi_gmem_ARQOS <= ap_const_lv4_0;
    m_axi_gmem_ARREGION <= ap_const_lv4_0;
    m_axi_gmem_ARSIZE <= ap_const_lv3_0;
    m_axi_gmem_ARUSER <= ap_const_lv1_0;
    m_axi_gmem_ARVALID <= ap_const_logic_0;

    m_axi_gmem_AWADDR_assign_proc : process(ap_CS_fsm_state2, icmp_ln1057_reg_118, grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWADDR, ap_CS_fsm_state3, ap_CS_fsm_state4, sext_ln57_fu_97_p1, ap_block_state2_io)
    begin
        if (((icmp_ln1057_reg_118 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2) and (ap_const_boolean_0 = ap_block_state2_io))) then 
            m_axi_gmem_AWADDR <= sext_ln57_fu_97_p1;
        elsif (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWADDR <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWADDR;
        else 
            m_axi_gmem_AWADDR <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    m_axi_gmem_AWBURST_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWBURST, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWBURST <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWBURST;
        else 
            m_axi_gmem_AWBURST <= ap_const_lv2_0;
        end if; 
    end process;


    m_axi_gmem_AWCACHE_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWCACHE, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWCACHE <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWCACHE;
        else 
            m_axi_gmem_AWCACHE <= ap_const_lv4_0;
        end if; 
    end process;


    m_axi_gmem_AWID_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWID, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWID <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWID;
        else 
            m_axi_gmem_AWID <= ap_const_lv1_0;
        end if; 
    end process;


    m_axi_gmem_AWLEN_assign_proc : process(ap_CS_fsm_state2, icmp_ln1057_reg_118, grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWLEN, ap_CS_fsm_state3, ap_CS_fsm_state4, ap_block_state2_io, zext_ln57_fu_108_p1)
    begin
        if (((icmp_ln1057_reg_118 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2) and (ap_const_boolean_0 = ap_block_state2_io))) then 
            m_axi_gmem_AWLEN <= zext_ln57_fu_108_p1;
        elsif (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWLEN <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWLEN;
        else 
            m_axi_gmem_AWLEN <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        end if; 
    end process;


    m_axi_gmem_AWLOCK_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWLOCK, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWLOCK <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWLOCK;
        else 
            m_axi_gmem_AWLOCK <= ap_const_lv2_0;
        end if; 
    end process;


    m_axi_gmem_AWPROT_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWPROT, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWPROT <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWPROT;
        else 
            m_axi_gmem_AWPROT <= ap_const_lv3_0;
        end if; 
    end process;


    m_axi_gmem_AWQOS_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWQOS, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWQOS <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWQOS;
        else 
            m_axi_gmem_AWQOS <= ap_const_lv4_0;
        end if; 
    end process;


    m_axi_gmem_AWREGION_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWREGION, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWREGION <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWREGION;
        else 
            m_axi_gmem_AWREGION <= ap_const_lv4_0;
        end if; 
    end process;


    m_axi_gmem_AWSIZE_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWSIZE, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWSIZE <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWSIZE;
        else 
            m_axi_gmem_AWSIZE <= ap_const_lv3_0;
        end if; 
    end process;


    m_axi_gmem_AWUSER_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWUSER, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWUSER <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWUSER;
        else 
            m_axi_gmem_AWUSER <= ap_const_lv1_0;
        end if; 
    end process;


    m_axi_gmem_AWVALID_assign_proc : process(ap_CS_fsm_state2, icmp_ln1057_reg_118, grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWVALID, ap_CS_fsm_state3, ap_CS_fsm_state4, ap_block_state2_io)
    begin
        if (((icmp_ln1057_reg_118 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state2) and (ap_const_boolean_0 = ap_block_state2_io))) then 
            m_axi_gmem_AWVALID <= ap_const_logic_1;
        elsif (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_AWVALID <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_AWVALID;
        else 
            m_axi_gmem_AWVALID <= ap_const_logic_0;
        end if; 
    end process;


    m_axi_gmem_BREADY_assign_proc : process(m_axi_gmem_BVALID, icmp_ln1057_reg_118, ap_CS_fsm_state9, grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_BREADY, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if ((not(((icmp_ln1057_reg_118 = ap_const_lv1_0) and (m_axi_gmem_BVALID = ap_const_logic_0))) and (icmp_ln1057_reg_118 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state9))) then 
            m_axi_gmem_BREADY <= ap_const_logic_1;
        elsif (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_BREADY <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_BREADY;
        else 
            m_axi_gmem_BREADY <= ap_const_logic_0;
        end if; 
    end process;

    m_axi_gmem_RREADY <= ap_const_logic_0;
    m_axi_gmem_WDATA <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WDATA;
    m_axi_gmem_WID <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WID;
    m_axi_gmem_WLAST <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WLAST;
    m_axi_gmem_WSTRB <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WSTRB;
    m_axi_gmem_WUSER <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WUSER;

    m_axi_gmem_WVALID_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WVALID, ap_CS_fsm_state3, ap_CS_fsm_state4)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state4) or (ap_const_logic_1 = ap_CS_fsm_state3))) then 
            m_axi_gmem_WVALID <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_m_axi_gmem_WVALID;
        else 
            m_axi_gmem_WVALID <= ap_const_logic_0;
        end if; 
    end process;

        sext_ln57_fu_97_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(trunc_ln_fu_87_p4),64));


    toout17_read_assign_proc : process(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_toout17_read, ap_CS_fsm_state4)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state4)) then 
            toout17_read <= grp_put_data_csize_ap_uint_256_Pipeline_write_fu_71_toout17_read;
        else 
            toout17_read <= ap_const_logic_0;
        end if; 
    end process;

    trunc_ln_fu_87_p4 <= p_read1(63 downto 5);
    zext_ln57_fu_108_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(p_read),32));
end behav;
