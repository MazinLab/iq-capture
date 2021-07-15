// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="adc_capture_adc_capture,hls_ip_2021_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu28dr-ffvg1517-2-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=1.452688,HLS_SYN_LAT=-1,HLS_SYN_TPT=-1,HLS_SYN_MEM=30,HLS_SYN_DSP=0,HLS_SYN_FF=2163,HLS_SYN_LUT=2153,HLS_VERSION=2021_1}" *)

module adc_capture (
// synthesis translate_off
    kernel_block,
// synthesis translate_on
        s_axi_control_AWVALID,
        s_axi_control_AWREADY,
        s_axi_control_AWADDR,
        s_axi_control_WVALID,
        s_axi_control_WREADY,
        s_axi_control_WDATA,
        s_axi_control_WSTRB,
        s_axi_control_ARVALID,
        s_axi_control_ARREADY,
        s_axi_control_ARADDR,
        s_axi_control_RVALID,
        s_axi_control_RREADY,
        s_axi_control_RDATA,
        s_axi_control_RRESP,
        s_axi_control_BVALID,
        s_axi_control_BREADY,
        s_axi_control_BRESP,
        ap_clk,
        ap_rst_n,
        interrupt,
        m_axi_gmem_AWVALID,
        m_axi_gmem_AWREADY,
        m_axi_gmem_AWADDR,
        m_axi_gmem_AWID,
        m_axi_gmem_AWLEN,
        m_axi_gmem_AWSIZE,
        m_axi_gmem_AWBURST,
        m_axi_gmem_AWLOCK,
        m_axi_gmem_AWCACHE,
        m_axi_gmem_AWPROT,
        m_axi_gmem_AWQOS,
        m_axi_gmem_AWREGION,
        m_axi_gmem_AWUSER,
        m_axi_gmem_WVALID,
        m_axi_gmem_WREADY,
        m_axi_gmem_WDATA,
        m_axi_gmem_WSTRB,
        m_axi_gmem_WLAST,
        m_axi_gmem_WID,
        m_axi_gmem_WUSER,
        m_axi_gmem_ARVALID,
        m_axi_gmem_ARREADY,
        m_axi_gmem_ARADDR,
        m_axi_gmem_ARID,
        m_axi_gmem_ARLEN,
        m_axi_gmem_ARSIZE,
        m_axi_gmem_ARBURST,
        m_axi_gmem_ARLOCK,
        m_axi_gmem_ARCACHE,
        m_axi_gmem_ARPROT,
        m_axi_gmem_ARQOS,
        m_axi_gmem_ARREGION,
        m_axi_gmem_ARUSER,
        m_axi_gmem_RVALID,
        m_axi_gmem_RREADY,
        m_axi_gmem_RDATA,
        m_axi_gmem_RLAST,
        m_axi_gmem_RID,
        m_axi_gmem_RUSER,
        m_axi_gmem_RRESP,
        m_axi_gmem_BVALID,
        m_axi_gmem_BREADY,
        m_axi_gmem_BRESP,
        m_axi_gmem_BID,
        m_axi_gmem_BUSER,
        istream_V_TDATA,
        qstream_V_TDATA,
        istream_V_TVALID,
        istream_V_TREADY,
        qstream_V_TVALID,
        qstream_V_TREADY
);

parameter    C_S_AXI_CONTROL_DATA_WIDTH = 32;
parameter    C_S_AXI_CONTROL_ADDR_WIDTH = 6;
parameter    C_S_AXI_DATA_WIDTH = 32;
parameter    C_M_AXI_GMEM_ID_WIDTH = 1;
parameter    C_M_AXI_GMEM_ADDR_WIDTH = 64;
parameter    C_M_AXI_GMEM_DATA_WIDTH = 256;
parameter    C_M_AXI_GMEM_AWUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM_ARUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM_WUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM_RUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM_BUSER_WIDTH = 1;
parameter    C_M_AXI_GMEM_USER_VALUE = 0;
parameter    C_M_AXI_GMEM_PROT_VALUE = 0;
parameter    C_M_AXI_GMEM_CACHE_VALUE = 3;
parameter    C_M_AXI_DATA_WIDTH = 32;

parameter C_S_AXI_CONTROL_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);
parameter C_M_AXI_GMEM_WSTRB_WIDTH = (256 / 8);
parameter C_M_AXI_WSTRB_WIDTH = (32 / 8);

// synthesis translate_off
output kernel_block;
// synthesis translate_on
input   s_axi_control_AWVALID;
output   s_axi_control_AWREADY;
input  [C_S_AXI_CONTROL_ADDR_WIDTH - 1:0] s_axi_control_AWADDR;
input   s_axi_control_WVALID;
output   s_axi_control_WREADY;
input  [C_S_AXI_CONTROL_DATA_WIDTH - 1:0] s_axi_control_WDATA;
input  [C_S_AXI_CONTROL_WSTRB_WIDTH - 1:0] s_axi_control_WSTRB;
input   s_axi_control_ARVALID;
output   s_axi_control_ARREADY;
input  [C_S_AXI_CONTROL_ADDR_WIDTH - 1:0] s_axi_control_ARADDR;
output   s_axi_control_RVALID;
input   s_axi_control_RREADY;
output  [C_S_AXI_CONTROL_DATA_WIDTH - 1:0] s_axi_control_RDATA;
output  [1:0] s_axi_control_RRESP;
output   s_axi_control_BVALID;
input   s_axi_control_BREADY;
output  [1:0] s_axi_control_BRESP;
input   ap_clk;
input   ap_rst_n;
output   interrupt;
output   m_axi_gmem_AWVALID;
input   m_axi_gmem_AWREADY;
output  [C_M_AXI_GMEM_ADDR_WIDTH - 1:0] m_axi_gmem_AWADDR;
output  [C_M_AXI_GMEM_ID_WIDTH - 1:0] m_axi_gmem_AWID;
output  [7:0] m_axi_gmem_AWLEN;
output  [2:0] m_axi_gmem_AWSIZE;
output  [1:0] m_axi_gmem_AWBURST;
output  [1:0] m_axi_gmem_AWLOCK;
output  [3:0] m_axi_gmem_AWCACHE;
output  [2:0] m_axi_gmem_AWPROT;
output  [3:0] m_axi_gmem_AWQOS;
output  [3:0] m_axi_gmem_AWREGION;
output  [C_M_AXI_GMEM_AWUSER_WIDTH - 1:0] m_axi_gmem_AWUSER;
output   m_axi_gmem_WVALID;
input   m_axi_gmem_WREADY;
output  [C_M_AXI_GMEM_DATA_WIDTH - 1:0] m_axi_gmem_WDATA;
output  [C_M_AXI_GMEM_WSTRB_WIDTH - 1:0] m_axi_gmem_WSTRB;
output   m_axi_gmem_WLAST;
output  [C_M_AXI_GMEM_ID_WIDTH - 1:0] m_axi_gmem_WID;
output  [C_M_AXI_GMEM_WUSER_WIDTH - 1:0] m_axi_gmem_WUSER;
output   m_axi_gmem_ARVALID;
input   m_axi_gmem_ARREADY;
output  [C_M_AXI_GMEM_ADDR_WIDTH - 1:0] m_axi_gmem_ARADDR;
output  [C_M_AXI_GMEM_ID_WIDTH - 1:0] m_axi_gmem_ARID;
output  [7:0] m_axi_gmem_ARLEN;
output  [2:0] m_axi_gmem_ARSIZE;
output  [1:0] m_axi_gmem_ARBURST;
output  [1:0] m_axi_gmem_ARLOCK;
output  [3:0] m_axi_gmem_ARCACHE;
output  [2:0] m_axi_gmem_ARPROT;
output  [3:0] m_axi_gmem_ARQOS;
output  [3:0] m_axi_gmem_ARREGION;
output  [C_M_AXI_GMEM_ARUSER_WIDTH - 1:0] m_axi_gmem_ARUSER;
input   m_axi_gmem_RVALID;
output   m_axi_gmem_RREADY;
input  [C_M_AXI_GMEM_DATA_WIDTH - 1:0] m_axi_gmem_RDATA;
input   m_axi_gmem_RLAST;
input  [C_M_AXI_GMEM_ID_WIDTH - 1:0] m_axi_gmem_RID;
input  [C_M_AXI_GMEM_RUSER_WIDTH - 1:0] m_axi_gmem_RUSER;
input  [1:0] m_axi_gmem_RRESP;
input   m_axi_gmem_BVALID;
output   m_axi_gmem_BREADY;
input  [1:0] m_axi_gmem_BRESP;
input  [C_M_AXI_GMEM_ID_WIDTH - 1:0] m_axi_gmem_BID;
input  [C_M_AXI_GMEM_BUSER_WIDTH - 1:0] m_axi_gmem_BUSER;
input  [127:0] istream_V_TDATA;
input  [127:0] qstream_V_TDATA;
input   istream_V_TVALID;
output   istream_V_TREADY;
input   qstream_V_TVALID;
output   qstream_V_TREADY;

 reg    ap_rst_n_inv;
wire   [26:0] capturesize;
wire   [63:0] iqout;
wire    ap_start;
wire    ap_ready;
wire    ap_done;
wire    ap_idle;
wire    gmem_AWREADY;
wire    gmem_WREADY;
wire    gmem_ARREADY;
wire    gmem_RVALID;
wire   [255:0] gmem_RDATA;
wire    gmem_RLAST;
wire   [0:0] gmem_RID;
wire   [0:0] gmem_RUSER;
wire   [1:0] gmem_RRESP;
wire    gmem_BVALID;
wire   [1:0] gmem_BRESP;
wire   [0:0] gmem_BID;
wire   [0:0] gmem_BUSER;
wire    entry_proc_U0_ap_start;
wire    entry_proc_U0_ap_done;
wire    entry_proc_U0_ap_continue;
wire    entry_proc_U0_ap_idle;
wire    entry_proc_U0_ap_ready;
wire   [63:0] entry_proc_U0_ap_return;
wire    iqout_c_channel_full_n;
wire    pair_iq_df_flat_U0_ap_start;
wire    pair_iq_df_flat_U0_ap_done;
wire    pair_iq_df_flat_U0_ap_continue;
wire    pair_iq_df_flat_U0_ap_idle;
wire    pair_iq_df_flat_U0_ap_ready;
wire    pair_iq_df_flat_U0_istream_V_TREADY;
wire    pair_iq_df_flat_U0_qstream_V_TREADY;
wire   [255:0] pair_iq_df_flat_U0_iq_in8_din;
wire    pair_iq_df_flat_U0_iq_in8_write;
wire   [26:0] pair_iq_df_flat_U0_capturesize_c_din;
wire    pair_iq_df_flat_U0_capturesize_c_write;
wire    put_data_csize_ap_uint_256_U0_ap_start;
wire    put_data_csize_ap_uint_256_U0_ap_done;
wire    put_data_csize_ap_uint_256_U0_ap_continue;
wire    put_data_csize_ap_uint_256_U0_ap_idle;
wire    put_data_csize_ap_uint_256_U0_ap_ready;
wire    put_data_csize_ap_uint_256_U0_iq_in8_read;
wire    put_data_csize_ap_uint_256_U0_capturesize_read;
wire    put_data_csize_ap_uint_256_U0_m_axi_gmem_AWVALID;
wire   [63:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWADDR;
wire   [0:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWID;
wire   [31:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWLEN;
wire   [2:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWSIZE;
wire   [1:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWBURST;
wire   [1:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWLOCK;
wire   [3:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWCACHE;
wire   [2:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWPROT;
wire   [3:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWQOS;
wire   [3:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWREGION;
wire   [0:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_AWUSER;
wire    put_data_csize_ap_uint_256_U0_m_axi_gmem_WVALID;
wire   [255:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_WDATA;
wire   [31:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_WSTRB;
wire    put_data_csize_ap_uint_256_U0_m_axi_gmem_WLAST;
wire   [0:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_WID;
wire   [0:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_WUSER;
wire    put_data_csize_ap_uint_256_U0_m_axi_gmem_ARVALID;
wire   [63:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARADDR;
wire   [0:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARID;
wire   [31:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARLEN;
wire   [2:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARSIZE;
wire   [1:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARBURST;
wire   [1:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARLOCK;
wire   [3:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARCACHE;
wire   [2:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARPROT;
wire   [3:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARQOS;
wire   [3:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARREGION;
wire   [0:0] put_data_csize_ap_uint_256_U0_m_axi_gmem_ARUSER;
wire    put_data_csize_ap_uint_256_U0_m_axi_gmem_RREADY;
wire    put_data_csize_ap_uint_256_U0_m_axi_gmem_BREADY;
wire   [63:0] iqout_c_channel_dout;
wire    iqout_c_channel_empty_n;
wire    iq_in_full_n;
wire   [255:0] iq_in_dout;
wire    iq_in_empty_n;
wire    capturesize_c_full_n;
wire   [26:0] capturesize_c_dout;
wire    capturesize_c_empty_n;
wire    ap_sync_ready;
reg    ap_sync_reg_entry_proc_U0_ap_ready;
wire    ap_sync_entry_proc_U0_ap_ready;
reg    ap_sync_reg_pair_iq_df_flat_U0_ap_ready;
wire    ap_sync_pair_iq_df_flat_U0_ap_ready;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_sync_reg_entry_proc_U0_ap_ready = 1'b0;
#0 ap_sync_reg_pair_iq_df_flat_U0_ap_ready = 1'b0;
end

adc_capture_control_s_axi #(
    .C_S_AXI_ADDR_WIDTH( C_S_AXI_CONTROL_ADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( C_S_AXI_CONTROL_DATA_WIDTH ))
control_s_axi_U(
    .AWVALID(s_axi_control_AWVALID),
    .AWREADY(s_axi_control_AWREADY),
    .AWADDR(s_axi_control_AWADDR),
    .WVALID(s_axi_control_WVALID),
    .WREADY(s_axi_control_WREADY),
    .WDATA(s_axi_control_WDATA),
    .WSTRB(s_axi_control_WSTRB),
    .ARVALID(s_axi_control_ARVALID),
    .ARREADY(s_axi_control_ARREADY),
    .ARADDR(s_axi_control_ARADDR),
    .RVALID(s_axi_control_RVALID),
    .RREADY(s_axi_control_RREADY),
    .RDATA(s_axi_control_RDATA),
    .RRESP(s_axi_control_RRESP),
    .BVALID(s_axi_control_BVALID),
    .BREADY(s_axi_control_BREADY),
    .BRESP(s_axi_control_BRESP),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .capturesize(capturesize),
    .iqout(iqout),
    .ap_start(ap_start),
    .interrupt(interrupt),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_idle(ap_idle)
);

adc_capture_gmem_m_axi #(
    .CONSERVATIVE( 0 ),
    .USER_DW( 256 ),
    .USER_AW( 64 ),
    .USER_MAXREQS( 5 ),
    .NUM_READ_OUTSTANDING( 1 ),
    .NUM_WRITE_OUTSTANDING( 2 ),
    .MAX_READ_BURST_LENGTH( 2 ),
    .MAX_WRITE_BURST_LENGTH( 128 ),
    .C_M_AXI_ID_WIDTH( C_M_AXI_GMEM_ID_WIDTH ),
    .C_M_AXI_ADDR_WIDTH( C_M_AXI_GMEM_ADDR_WIDTH ),
    .C_M_AXI_DATA_WIDTH( C_M_AXI_GMEM_DATA_WIDTH ),
    .C_M_AXI_AWUSER_WIDTH( C_M_AXI_GMEM_AWUSER_WIDTH ),
    .C_M_AXI_ARUSER_WIDTH( C_M_AXI_GMEM_ARUSER_WIDTH ),
    .C_M_AXI_WUSER_WIDTH( C_M_AXI_GMEM_WUSER_WIDTH ),
    .C_M_AXI_RUSER_WIDTH( C_M_AXI_GMEM_RUSER_WIDTH ),
    .C_M_AXI_BUSER_WIDTH( C_M_AXI_GMEM_BUSER_WIDTH ),
    .C_USER_VALUE( C_M_AXI_GMEM_USER_VALUE ),
    .C_PROT_VALUE( C_M_AXI_GMEM_PROT_VALUE ),
    .C_CACHE_VALUE( C_M_AXI_GMEM_CACHE_VALUE ))
gmem_m_axi_U(
    .AWVALID(m_axi_gmem_AWVALID),
    .AWREADY(m_axi_gmem_AWREADY),
    .AWADDR(m_axi_gmem_AWADDR),
    .AWID(m_axi_gmem_AWID),
    .AWLEN(m_axi_gmem_AWLEN),
    .AWSIZE(m_axi_gmem_AWSIZE),
    .AWBURST(m_axi_gmem_AWBURST),
    .AWLOCK(m_axi_gmem_AWLOCK),
    .AWCACHE(m_axi_gmem_AWCACHE),
    .AWPROT(m_axi_gmem_AWPROT),
    .AWQOS(m_axi_gmem_AWQOS),
    .AWREGION(m_axi_gmem_AWREGION),
    .AWUSER(m_axi_gmem_AWUSER),
    .WVALID(m_axi_gmem_WVALID),
    .WREADY(m_axi_gmem_WREADY),
    .WDATA(m_axi_gmem_WDATA),
    .WSTRB(m_axi_gmem_WSTRB),
    .WLAST(m_axi_gmem_WLAST),
    .WID(m_axi_gmem_WID),
    .WUSER(m_axi_gmem_WUSER),
    .ARVALID(m_axi_gmem_ARVALID),
    .ARREADY(m_axi_gmem_ARREADY),
    .ARADDR(m_axi_gmem_ARADDR),
    .ARID(m_axi_gmem_ARID),
    .ARLEN(m_axi_gmem_ARLEN),
    .ARSIZE(m_axi_gmem_ARSIZE),
    .ARBURST(m_axi_gmem_ARBURST),
    .ARLOCK(m_axi_gmem_ARLOCK),
    .ARCACHE(m_axi_gmem_ARCACHE),
    .ARPROT(m_axi_gmem_ARPROT),
    .ARQOS(m_axi_gmem_ARQOS),
    .ARREGION(m_axi_gmem_ARREGION),
    .ARUSER(m_axi_gmem_ARUSER),
    .RVALID(m_axi_gmem_RVALID),
    .RREADY(m_axi_gmem_RREADY),
    .RDATA(m_axi_gmem_RDATA),
    .RLAST(m_axi_gmem_RLAST),
    .RID(m_axi_gmem_RID),
    .RUSER(m_axi_gmem_RUSER),
    .RRESP(m_axi_gmem_RRESP),
    .BVALID(m_axi_gmem_BVALID),
    .BREADY(m_axi_gmem_BREADY),
    .BRESP(m_axi_gmem_BRESP),
    .BID(m_axi_gmem_BID),
    .BUSER(m_axi_gmem_BUSER),
    .ACLK(ap_clk),
    .ARESET(ap_rst_n_inv),
    .ACLK_EN(1'b1),
    .I_ARVALID(1'b0),
    .I_ARREADY(gmem_ARREADY),
    .I_ARADDR(64'd0),
    .I_ARID(1'd0),
    .I_ARLEN(32'd0),
    .I_ARSIZE(3'd0),
    .I_ARLOCK(2'd0),
    .I_ARCACHE(4'd0),
    .I_ARQOS(4'd0),
    .I_ARPROT(3'd0),
    .I_ARUSER(1'd0),
    .I_ARBURST(2'd0),
    .I_ARREGION(4'd0),
    .I_RVALID(gmem_RVALID),
    .I_RREADY(1'b0),
    .I_RDATA(gmem_RDATA),
    .I_RID(gmem_RID),
    .I_RUSER(gmem_RUSER),
    .I_RRESP(gmem_RRESP),
    .I_RLAST(gmem_RLAST),
    .I_AWVALID(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWVALID),
    .I_AWREADY(gmem_AWREADY),
    .I_AWADDR(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWADDR),
    .I_AWID(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWID),
    .I_AWLEN(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWLEN),
    .I_AWSIZE(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWSIZE),
    .I_AWLOCK(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWLOCK),
    .I_AWCACHE(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWCACHE),
    .I_AWQOS(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWQOS),
    .I_AWPROT(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWPROT),
    .I_AWUSER(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWUSER),
    .I_AWBURST(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWBURST),
    .I_AWREGION(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWREGION),
    .I_WVALID(put_data_csize_ap_uint_256_U0_m_axi_gmem_WVALID),
    .I_WREADY(gmem_WREADY),
    .I_WDATA(put_data_csize_ap_uint_256_U0_m_axi_gmem_WDATA),
    .I_WID(put_data_csize_ap_uint_256_U0_m_axi_gmem_WID),
    .I_WUSER(put_data_csize_ap_uint_256_U0_m_axi_gmem_WUSER),
    .I_WLAST(put_data_csize_ap_uint_256_U0_m_axi_gmem_WLAST),
    .I_WSTRB(put_data_csize_ap_uint_256_U0_m_axi_gmem_WSTRB),
    .I_BVALID(gmem_BVALID),
    .I_BREADY(put_data_csize_ap_uint_256_U0_m_axi_gmem_BREADY),
    .I_BRESP(gmem_BRESP),
    .I_BID(gmem_BID),
    .I_BUSER(gmem_BUSER)
);

adc_capture_entry_proc entry_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(entry_proc_U0_ap_start),
    .ap_done(entry_proc_U0_ap_done),
    .ap_continue(entry_proc_U0_ap_continue),
    .ap_idle(entry_proc_U0_ap_idle),
    .ap_ready(entry_proc_U0_ap_ready),
    .iqout(iqout),
    .ap_return(entry_proc_U0_ap_return)
);

adc_capture_pair_iq_df_flat pair_iq_df_flat_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(pair_iq_df_flat_U0_ap_start),
    .ap_done(pair_iq_df_flat_U0_ap_done),
    .ap_continue(pair_iq_df_flat_U0_ap_continue),
    .ap_idle(pair_iq_df_flat_U0_ap_idle),
    .ap_ready(pair_iq_df_flat_U0_ap_ready),
    .istream_V_TDATA(istream_V_TDATA),
    .istream_V_TVALID(istream_V_TVALID),
    .istream_V_TREADY(pair_iq_df_flat_U0_istream_V_TREADY),
    .qstream_V_TDATA(qstream_V_TDATA),
    .qstream_V_TVALID(qstream_V_TVALID),
    .qstream_V_TREADY(pair_iq_df_flat_U0_qstream_V_TREADY),
    .capturesize(capturesize),
    .iq_in8_din(pair_iq_df_flat_U0_iq_in8_din),
    .iq_in8_full_n(iq_in_full_n),
    .iq_in8_write(pair_iq_df_flat_U0_iq_in8_write),
    .capturesize_c_din(pair_iq_df_flat_U0_capturesize_c_din),
    .capturesize_c_full_n(capturesize_c_full_n),
    .capturesize_c_write(pair_iq_df_flat_U0_capturesize_c_write)
);

adc_capture_put_data_csize_ap_uint_256_s put_data_csize_ap_uint_256_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(put_data_csize_ap_uint_256_U0_ap_start),
    .ap_done(put_data_csize_ap_uint_256_U0_ap_done),
    .ap_continue(put_data_csize_ap_uint_256_U0_ap_continue),
    .ap_idle(put_data_csize_ap_uint_256_U0_ap_idle),
    .ap_ready(put_data_csize_ap_uint_256_U0_ap_ready),
    .iq_in8_dout(iq_in_dout),
    .iq_in8_empty_n(iq_in_empty_n),
    .iq_in8_read(put_data_csize_ap_uint_256_U0_iq_in8_read),
    .capturesize_dout(capturesize_c_dout),
    .capturesize_empty_n(capturesize_c_empty_n),
    .capturesize_read(put_data_csize_ap_uint_256_U0_capturesize_read),
    .m_axi_gmem_AWVALID(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWVALID),
    .m_axi_gmem_AWREADY(gmem_AWREADY),
    .m_axi_gmem_AWADDR(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWADDR),
    .m_axi_gmem_AWID(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWID),
    .m_axi_gmem_AWLEN(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWLEN),
    .m_axi_gmem_AWSIZE(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWSIZE),
    .m_axi_gmem_AWBURST(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWBURST),
    .m_axi_gmem_AWLOCK(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWLOCK),
    .m_axi_gmem_AWCACHE(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWCACHE),
    .m_axi_gmem_AWPROT(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWPROT),
    .m_axi_gmem_AWQOS(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWQOS),
    .m_axi_gmem_AWREGION(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWREGION),
    .m_axi_gmem_AWUSER(put_data_csize_ap_uint_256_U0_m_axi_gmem_AWUSER),
    .m_axi_gmem_WVALID(put_data_csize_ap_uint_256_U0_m_axi_gmem_WVALID),
    .m_axi_gmem_WREADY(gmem_WREADY),
    .m_axi_gmem_WDATA(put_data_csize_ap_uint_256_U0_m_axi_gmem_WDATA),
    .m_axi_gmem_WSTRB(put_data_csize_ap_uint_256_U0_m_axi_gmem_WSTRB),
    .m_axi_gmem_WLAST(put_data_csize_ap_uint_256_U0_m_axi_gmem_WLAST),
    .m_axi_gmem_WID(put_data_csize_ap_uint_256_U0_m_axi_gmem_WID),
    .m_axi_gmem_WUSER(put_data_csize_ap_uint_256_U0_m_axi_gmem_WUSER),
    .m_axi_gmem_ARVALID(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARVALID),
    .m_axi_gmem_ARREADY(1'b0),
    .m_axi_gmem_ARADDR(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARADDR),
    .m_axi_gmem_ARID(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARID),
    .m_axi_gmem_ARLEN(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARLEN),
    .m_axi_gmem_ARSIZE(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARSIZE),
    .m_axi_gmem_ARBURST(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARBURST),
    .m_axi_gmem_ARLOCK(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARLOCK),
    .m_axi_gmem_ARCACHE(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARCACHE),
    .m_axi_gmem_ARPROT(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARPROT),
    .m_axi_gmem_ARQOS(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARQOS),
    .m_axi_gmem_ARREGION(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARREGION),
    .m_axi_gmem_ARUSER(put_data_csize_ap_uint_256_U0_m_axi_gmem_ARUSER),
    .m_axi_gmem_RVALID(1'b0),
    .m_axi_gmem_RREADY(put_data_csize_ap_uint_256_U0_m_axi_gmem_RREADY),
    .m_axi_gmem_RDATA(256'd0),
    .m_axi_gmem_RLAST(1'b0),
    .m_axi_gmem_RID(1'd0),
    .m_axi_gmem_RUSER(1'd0),
    .m_axi_gmem_RRESP(2'd0),
    .m_axi_gmem_BVALID(gmem_BVALID),
    .m_axi_gmem_BREADY(put_data_csize_ap_uint_256_U0_m_axi_gmem_BREADY),
    .m_axi_gmem_BRESP(gmem_BRESP),
    .m_axi_gmem_BID(gmem_BID),
    .m_axi_gmem_BUSER(gmem_BUSER),
    .p_read(iqout_c_channel_dout)
);

adc_capture_fifo_w64_d2_S iqout_c_channel_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(entry_proc_U0_ap_return),
    .if_full_n(iqout_c_channel_full_n),
    .if_write(entry_proc_U0_ap_done),
    .if_dout(iqout_c_channel_dout),
    .if_empty_n(iqout_c_channel_empty_n),
    .if_read(put_data_csize_ap_uint_256_U0_ap_ready)
);

adc_capture_fifo_w256_d4_S iq_in_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(pair_iq_df_flat_U0_iq_in8_din),
    .if_full_n(iq_in_full_n),
    .if_write(pair_iq_df_flat_U0_iq_in8_write),
    .if_dout(iq_in_dout),
    .if_empty_n(iq_in_empty_n),
    .if_read(put_data_csize_ap_uint_256_U0_iq_in8_read)
);

adc_capture_fifo_w27_d2_S capturesize_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(pair_iq_df_flat_U0_capturesize_c_din),
    .if_full_n(capturesize_c_full_n),
    .if_write(pair_iq_df_flat_U0_capturesize_c_write),
    .if_dout(capturesize_c_dout),
    .if_empty_n(capturesize_c_empty_n),
    .if_read(put_data_csize_ap_uint_256_U0_capturesize_read)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_sync_reg_entry_proc_U0_ap_ready <= 1'b0;
    end else begin
        if (((ap_sync_ready & ap_start) == 1'b1)) begin
            ap_sync_reg_entry_proc_U0_ap_ready <= 1'b0;
        end else begin
            ap_sync_reg_entry_proc_U0_ap_ready <= ap_sync_entry_proc_U0_ap_ready;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_sync_reg_pair_iq_df_flat_U0_ap_ready <= 1'b0;
    end else begin
        if (((ap_sync_ready & ap_start) == 1'b1)) begin
            ap_sync_reg_pair_iq_df_flat_U0_ap_ready <= 1'b0;
        end else begin
            ap_sync_reg_pair_iq_df_flat_U0_ap_ready <= ap_sync_pair_iq_df_flat_U0_ap_ready;
        end
    end
end

assign ap_done = put_data_csize_ap_uint_256_U0_ap_done;

assign ap_idle = (put_data_csize_ap_uint_256_U0_ap_idle & pair_iq_df_flat_U0_ap_idle & (iqout_c_channel_empty_n ^ 1'b1) & entry_proc_U0_ap_idle);

assign ap_ready = ap_sync_ready;

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign ap_sync_entry_proc_U0_ap_ready = (entry_proc_U0_ap_ready | ap_sync_reg_entry_proc_U0_ap_ready);

assign ap_sync_pair_iq_df_flat_U0_ap_ready = (pair_iq_df_flat_U0_ap_ready | ap_sync_reg_pair_iq_df_flat_U0_ap_ready);

assign ap_sync_ready = (ap_sync_pair_iq_df_flat_U0_ap_ready & ap_sync_entry_proc_U0_ap_ready);

assign entry_proc_U0_ap_continue = iqout_c_channel_full_n;

assign entry_proc_U0_ap_start = ((ap_sync_reg_entry_proc_U0_ap_ready ^ 1'b1) & ap_start);

assign istream_V_TREADY = pair_iq_df_flat_U0_istream_V_TREADY;

assign pair_iq_df_flat_U0_ap_continue = 1'b1;

assign pair_iq_df_flat_U0_ap_start = ((ap_sync_reg_pair_iq_df_flat_U0_ap_ready ^ 1'b1) & ap_start);

assign put_data_csize_ap_uint_256_U0_ap_continue = 1'b1;

assign put_data_csize_ap_uint_256_U0_ap_start = iqout_c_channel_empty_n;

assign qstream_V_TREADY = pair_iq_df_flat_U0_qstream_V_TREADY;


// synthesis translate_off
`include "adc_capture_hls_deadlock_detector.vh"
`include "adc_capture_hls_deadlock_kernel_monitor_top.vh"
// synthesis translate_on

endmodule //adc_capture

