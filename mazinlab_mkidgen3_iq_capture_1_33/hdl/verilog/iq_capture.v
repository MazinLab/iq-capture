// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="iq_capture_iq_capture,hls_ip_2021_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu28dr-ffvg1517-2-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=1.463375,HLS_SYN_LAT=-1,HLS_SYN_TPT=-1,HLS_SYN_MEM=30,HLS_SYN_DSP=0,HLS_SYN_FF=3661,HLS_SYN_LUT=3197,HLS_VERSION=2021_1}" *)

module iq_capture (
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
        resstream_TDATA,
        resstream_TKEEP,
        resstream_TSTRB,
        resstream_TUSER,
        resstream_TLAST,
        resstream_TVALID,
        resstream_TREADY
);

parameter    C_S_AXI_CONTROL_DATA_WIDTH = 32;
parameter    C_S_AXI_CONTROL_ADDR_WIDTH = 7;
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
input  [255:0] resstream_TDATA;
input  [31:0] resstream_TKEEP;
input  [31:0] resstream_TSTRB;
input  [7:0] resstream_TUSER;
input  [0:0] resstream_TLAST;
input   resstream_TVALID;
output   resstream_TREADY;

 reg    ap_rst_n_inv;
wire   [255:0] keep;
wire   [34:0] total_capturesize;
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
wire   [26:0] entry_proc_U0_ap_return_0;
wire   [63:0] entry_proc_U0_ap_return_1;
wire    ap_channel_done_iqout_c_channel;
wire    iqout_c_channel_full_n;
reg    ap_sync_reg_channel_write_iqout_c_channel;
wire    ap_sync_channel_write_iqout_c_channel;
wire    ap_channel_done_capturesize_c_channel;
wire    capturesize_c_channel_full_n;
reg    ap_sync_reg_channel_write_capturesize_c_channel;
wire    ap_sync_channel_write_capturesize_c_channel;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_start;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_done;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_continue;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_idle;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_start_out;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_start_write;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_resstream_TREADY;
wire   [255:0] fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched16_din;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched16_write;
wire   [0:0] fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched_keep18_din;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched_keep18_write;
wire   [34:0] fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_total_capturesize_c_din;
wire    fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_total_capturesize_c_write;
wire    capture_data_ap_uint_256_U0_ap_start;
wire    capture_data_ap_uint_256_U0_ap_done;
wire    capture_data_ap_uint_256_U0_ap_continue;
wire    capture_data_ap_uint_256_U0_ap_idle;
wire    capture_data_ap_uint_256_U0_ap_ready;
wire    capture_data_ap_uint_256_U0_fetched16_read;
wire    capture_data_ap_uint_256_U0_fetched_keep18_read;
wire    capture_data_ap_uint_256_U0_capturesize_read;
wire   [255:0] capture_data_ap_uint_256_U0_toout17_din;
wire    capture_data_ap_uint_256_U0_toout17_write;
wire    put_data_csize_ap_uint_256_U0_ap_start;
wire    put_data_csize_ap_uint_256_U0_ap_done;
wire    put_data_csize_ap_uint_256_U0_ap_continue;
wire    put_data_csize_ap_uint_256_U0_ap_idle;
wire    put_data_csize_ap_uint_256_U0_ap_ready;
wire    put_data_csize_ap_uint_256_U0_toout17_read;
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
wire   [26:0] capturesize_c_channel_dout;
wire    capturesize_c_channel_empty_n;
wire   [63:0] iqout_c_channel_dout;
wire    iqout_c_channel_empty_n;
wire    fetched_full_n;
wire   [255:0] fetched_dout;
wire    fetched_empty_n;
wire    fetched_keep_full_n;
wire   [0:0] fetched_keep_dout;
wire    fetched_keep_empty_n;
wire    total_capturesize_c_full_n;
wire   [34:0] total_capturesize_c_dout;
wire    total_capturesize_c_empty_n;
wire    toout_full_n;
wire   [255:0] toout_dout;
wire    toout_empty_n;
wire    ap_sync_ready;
reg    ap_sync_reg_entry_proc_U0_ap_ready;
wire    ap_sync_entry_proc_U0_ap_ready;
reg    ap_sync_reg_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready;
wire    ap_sync_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready;
wire   [0:0] start_for_capture_data_ap_uint_256_U0_din;
wire    start_for_capture_data_ap_uint_256_U0_full_n;
wire   [0:0] start_for_capture_data_ap_uint_256_U0_dout;
wire    start_for_capture_data_ap_uint_256_U0_empty_n;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_sync_reg_channel_write_iqout_c_channel = 1'b0;
#0 ap_sync_reg_channel_write_capturesize_c_channel = 1'b0;
#0 ap_sync_reg_entry_proc_U0_ap_ready = 1'b0;
#0 ap_sync_reg_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready = 1'b0;
end

iq_capture_control_s_axi #(
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
    .keep(keep),
    .total_capturesize(total_capturesize),
    .capturesize(capturesize),
    .iqout(iqout),
    .ap_start(ap_start),
    .interrupt(interrupt),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_idle(ap_idle)
);

iq_capture_gmem_m_axi #(
    .CONSERVATIVE( 0 ),
    .USER_DW( 256 ),
    .USER_AW( 64 ),
    .USER_MAXREQS( 5 ),
    .NUM_READ_OUTSTANDING( 1 ),
    .NUM_WRITE_OUTSTANDING( 4 ),
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

iq_capture_entry_proc entry_proc_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(entry_proc_U0_ap_start),
    .ap_done(entry_proc_U0_ap_done),
    .ap_continue(entry_proc_U0_ap_continue),
    .ap_idle(entry_proc_U0_ap_idle),
    .ap_ready(entry_proc_U0_ap_ready),
    .capturesize(capturesize),
    .iqout(iqout),
    .ap_return_0(entry_proc_U0_ap_return_0),
    .ap_return_1(entry_proc_U0_ap_return_1)
);

iq_capture_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_s fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_start),
    .start_full_n(start_for_capture_data_ap_uint_256_U0_full_n),
    .ap_done(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_done),
    .ap_continue(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_continue),
    .ap_idle(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_idle),
    .ap_ready(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready),
    .start_out(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_start_out),
    .start_write(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_start_write),
    .resstream_TDATA(resstream_TDATA),
    .resstream_TVALID(resstream_TVALID),
    .resstream_TREADY(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_resstream_TREADY),
    .resstream_TKEEP(resstream_TKEEP),
    .resstream_TSTRB(resstream_TSTRB),
    .resstream_TUSER(resstream_TUSER),
    .resstream_TLAST(resstream_TLAST),
    .capturesize(total_capturesize),
    .keep(keep),
    .fetched16_din(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched16_din),
    .fetched16_full_n(fetched_full_n),
    .fetched16_write(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched16_write),
    .fetched_keep18_din(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched_keep18_din),
    .fetched_keep18_full_n(fetched_keep_full_n),
    .fetched_keep18_write(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched_keep18_write),
    .total_capturesize_c_din(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_total_capturesize_c_din),
    .total_capturesize_c_full_n(total_capturesize_c_full_n),
    .total_capturesize_c_write(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_total_capturesize_c_write)
);

iq_capture_capture_data_ap_uint_256_s capture_data_ap_uint_256_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(capture_data_ap_uint_256_U0_ap_start),
    .ap_done(capture_data_ap_uint_256_U0_ap_done),
    .ap_continue(capture_data_ap_uint_256_U0_ap_continue),
    .ap_idle(capture_data_ap_uint_256_U0_ap_idle),
    .ap_ready(capture_data_ap_uint_256_U0_ap_ready),
    .fetched16_dout(fetched_dout),
    .fetched16_empty_n(fetched_empty_n),
    .fetched16_read(capture_data_ap_uint_256_U0_fetched16_read),
    .fetched_keep18_dout(fetched_keep_dout),
    .fetched_keep18_empty_n(fetched_keep_empty_n),
    .fetched_keep18_read(capture_data_ap_uint_256_U0_fetched_keep18_read),
    .capturesize_dout(total_capturesize_c_dout),
    .capturesize_empty_n(total_capturesize_c_empty_n),
    .capturesize_read(capture_data_ap_uint_256_U0_capturesize_read),
    .toout17_din(capture_data_ap_uint_256_U0_toout17_din),
    .toout17_full_n(toout_full_n),
    .toout17_write(capture_data_ap_uint_256_U0_toout17_write)
);

iq_capture_put_data_csize_ap_uint_256_s put_data_csize_ap_uint_256_U0(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .ap_start(put_data_csize_ap_uint_256_U0_ap_start),
    .ap_done(put_data_csize_ap_uint_256_U0_ap_done),
    .ap_continue(put_data_csize_ap_uint_256_U0_ap_continue),
    .ap_idle(put_data_csize_ap_uint_256_U0_ap_idle),
    .ap_ready(put_data_csize_ap_uint_256_U0_ap_ready),
    .toout17_dout(toout_dout),
    .toout17_empty_n(toout_empty_n),
    .toout17_read(put_data_csize_ap_uint_256_U0_toout17_read),
    .p_read(capturesize_c_channel_dout),
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
    .p_read1(iqout_c_channel_dout)
);

iq_capture_fifo_w27_d3_S capturesize_c_channel_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(entry_proc_U0_ap_return_0),
    .if_full_n(capturesize_c_channel_full_n),
    .if_write(ap_channel_done_capturesize_c_channel),
    .if_dout(capturesize_c_channel_dout),
    .if_empty_n(capturesize_c_channel_empty_n),
    .if_read(put_data_csize_ap_uint_256_U0_ap_ready)
);

iq_capture_fifo_w64_d3_S iqout_c_channel_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(entry_proc_U0_ap_return_1),
    .if_full_n(iqout_c_channel_full_n),
    .if_write(ap_channel_done_iqout_c_channel),
    .if_dout(iqout_c_channel_dout),
    .if_empty_n(iqout_c_channel_empty_n),
    .if_read(put_data_csize_ap_uint_256_U0_ap_ready)
);

iq_capture_fifo_w256_d2_S fetched_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched16_din),
    .if_full_n(fetched_full_n),
    .if_write(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched16_write),
    .if_dout(fetched_dout),
    .if_empty_n(fetched_empty_n),
    .if_read(capture_data_ap_uint_256_U0_fetched16_read)
);

iq_capture_fifo_w1_d2_S fetched_keep_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched_keep18_din),
    .if_full_n(fetched_keep_full_n),
    .if_write(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_fetched_keep18_write),
    .if_dout(fetched_keep_dout),
    .if_empty_n(fetched_keep_empty_n),
    .if_read(capture_data_ap_uint_256_U0_fetched_keep18_read)
);

iq_capture_fifo_w35_d2_S total_capturesize_c_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_total_capturesize_c_din),
    .if_full_n(total_capturesize_c_full_n),
    .if_write(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_total_capturesize_c_write),
    .if_dout(total_capturesize_c_dout),
    .if_empty_n(total_capturesize_c_empty_n),
    .if_read(capture_data_ap_uint_256_U0_capturesize_read)
);

iq_capture_fifo_w256_d2_S toout_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(capture_data_ap_uint_256_U0_toout17_din),
    .if_full_n(toout_full_n),
    .if_write(capture_data_ap_uint_256_U0_toout17_write),
    .if_dout(toout_dout),
    .if_empty_n(toout_empty_n),
    .if_read(put_data_csize_ap_uint_256_U0_toout17_read)
);

iq_capture_start_for_capture_data_ap_uint_256_U0 start_for_capture_data_ap_uint_256_U0_U(
    .clk(ap_clk),
    .reset(ap_rst_n_inv),
    .if_read_ce(1'b1),
    .if_write_ce(1'b1),
    .if_din(start_for_capture_data_ap_uint_256_U0_din),
    .if_full_n(start_for_capture_data_ap_uint_256_U0_full_n),
    .if_write(fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_start_write),
    .if_dout(start_for_capture_data_ap_uint_256_U0_dout),
    .if_empty_n(start_for_capture_data_ap_uint_256_U0_empty_n),
    .if_read(capture_data_ap_uint_256_U0_ap_ready)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_sync_reg_channel_write_capturesize_c_channel <= 1'b0;
    end else begin
        if (((entry_proc_U0_ap_done & entry_proc_U0_ap_continue) == 1'b1)) begin
            ap_sync_reg_channel_write_capturesize_c_channel <= 1'b0;
        end else begin
            ap_sync_reg_channel_write_capturesize_c_channel <= ap_sync_channel_write_capturesize_c_channel;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_sync_reg_channel_write_iqout_c_channel <= 1'b0;
    end else begin
        if (((entry_proc_U0_ap_done & entry_proc_U0_ap_continue) == 1'b1)) begin
            ap_sync_reg_channel_write_iqout_c_channel <= 1'b0;
        end else begin
            ap_sync_reg_channel_write_iqout_c_channel <= ap_sync_channel_write_iqout_c_channel;
        end
    end
end

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
        ap_sync_reg_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready <= 1'b0;
    end else begin
        if (((ap_sync_ready & ap_start) == 1'b1)) begin
            ap_sync_reg_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready <= 1'b0;
        end else begin
            ap_sync_reg_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready <= ap_sync_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready;
        end
    end
end

assign ap_channel_done_capturesize_c_channel = ((ap_sync_reg_channel_write_capturesize_c_channel ^ 1'b1) & entry_proc_U0_ap_done);

assign ap_channel_done_iqout_c_channel = ((ap_sync_reg_channel_write_iqout_c_channel ^ 1'b1) & entry_proc_U0_ap_done);

assign ap_done = put_data_csize_ap_uint_256_U0_ap_done;

assign ap_idle = (put_data_csize_ap_uint_256_U0_ap_idle & fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_idle & (iqout_c_channel_empty_n ^ 1'b1) & (capturesize_c_channel_empty_n ^ 1'b1) & entry_proc_U0_ap_idle & capture_data_ap_uint_256_U0_ap_idle);

assign ap_ready = ap_sync_ready;

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign ap_sync_channel_write_capturesize_c_channel = ((capturesize_c_channel_full_n & ap_channel_done_capturesize_c_channel) | ap_sync_reg_channel_write_capturesize_c_channel);

assign ap_sync_channel_write_iqout_c_channel = ((iqout_c_channel_full_n & ap_channel_done_iqout_c_channel) | ap_sync_reg_channel_write_iqout_c_channel);

assign ap_sync_entry_proc_U0_ap_ready = (entry_proc_U0_ap_ready | ap_sync_reg_entry_proc_U0_ap_ready);

assign ap_sync_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready = (fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready | ap_sync_reg_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready);

assign ap_sync_ready = (ap_sync_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready & ap_sync_entry_proc_U0_ap_ready);

assign capture_data_ap_uint_256_U0_ap_continue = 1'b1;

assign capture_data_ap_uint_256_U0_ap_start = start_for_capture_data_ap_uint_256_U0_empty_n;

assign entry_proc_U0_ap_continue = (ap_sync_channel_write_iqout_c_channel & ap_sync_channel_write_capturesize_c_channel);

assign entry_proc_U0_ap_start = ((ap_sync_reg_entry_proc_U0_ap_ready ^ 1'b1) & ap_start);

assign fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_continue = 1'b1;

assign fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_start = ((ap_sync_reg_fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_ap_ready ^ 1'b1) & ap_start);

assign put_data_csize_ap_uint_256_U0_ap_continue = 1'b1;

assign put_data_csize_ap_uint_256_U0_ap_start = (iqout_c_channel_empty_n & capturesize_c_channel_empty_n);

assign resstream_TREADY = fetch_data_axis_ap_uint_256_8ul_0ul_0ul_ap_uint_256_U0_resstream_TREADY;

assign start_for_capture_data_ap_uint_256_U0_din = 1'b1;


// synthesis translate_off
`include "iq_capture_hls_deadlock_detector.vh"
`include "iq_capture_hls_deadlock_kernel_monitor_top.vh"
// synthesis translate_on

endmodule //iq_capture

