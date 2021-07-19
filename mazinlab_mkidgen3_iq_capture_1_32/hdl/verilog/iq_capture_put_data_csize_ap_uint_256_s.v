// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module iq_capture_put_data_csize_ap_uint_256_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        toout17_dout,
        toout17_empty_n,
        toout17_read,
        capturesize,
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
        p_read
);

parameter    ap_ST_fsm_state1 = 11'd1;
parameter    ap_ST_fsm_state2 = 11'd2;
parameter    ap_ST_fsm_state3 = 11'd4;
parameter    ap_ST_fsm_state4 = 11'd8;
parameter    ap_ST_fsm_state5 = 11'd16;
parameter    ap_ST_fsm_state6 = 11'd32;
parameter    ap_ST_fsm_state7 = 11'd64;
parameter    ap_ST_fsm_state8 = 11'd128;
parameter    ap_ST_fsm_state9 = 11'd256;
parameter    ap_ST_fsm_state10 = 11'd512;
parameter    ap_ST_fsm_state11 = 11'd1024;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [255:0] toout17_dout;
input   toout17_empty_n;
output   toout17_read;
input  [26:0] capturesize;
output   m_axi_gmem_AWVALID;
input   m_axi_gmem_AWREADY;
output  [63:0] m_axi_gmem_AWADDR;
output  [0:0] m_axi_gmem_AWID;
output  [31:0] m_axi_gmem_AWLEN;
output  [2:0] m_axi_gmem_AWSIZE;
output  [1:0] m_axi_gmem_AWBURST;
output  [1:0] m_axi_gmem_AWLOCK;
output  [3:0] m_axi_gmem_AWCACHE;
output  [2:0] m_axi_gmem_AWPROT;
output  [3:0] m_axi_gmem_AWQOS;
output  [3:0] m_axi_gmem_AWREGION;
output  [0:0] m_axi_gmem_AWUSER;
output   m_axi_gmem_WVALID;
input   m_axi_gmem_WREADY;
output  [255:0] m_axi_gmem_WDATA;
output  [31:0] m_axi_gmem_WSTRB;
output   m_axi_gmem_WLAST;
output  [0:0] m_axi_gmem_WID;
output  [0:0] m_axi_gmem_WUSER;
output   m_axi_gmem_ARVALID;
input   m_axi_gmem_ARREADY;
output  [63:0] m_axi_gmem_ARADDR;
output  [0:0] m_axi_gmem_ARID;
output  [31:0] m_axi_gmem_ARLEN;
output  [2:0] m_axi_gmem_ARSIZE;
output  [1:0] m_axi_gmem_ARBURST;
output  [1:0] m_axi_gmem_ARLOCK;
output  [3:0] m_axi_gmem_ARCACHE;
output  [2:0] m_axi_gmem_ARPROT;
output  [3:0] m_axi_gmem_ARQOS;
output  [3:0] m_axi_gmem_ARREGION;
output  [0:0] m_axi_gmem_ARUSER;
input   m_axi_gmem_RVALID;
output   m_axi_gmem_RREADY;
input  [255:0] m_axi_gmem_RDATA;
input   m_axi_gmem_RLAST;
input  [0:0] m_axi_gmem_RID;
input  [0:0] m_axi_gmem_RUSER;
input  [1:0] m_axi_gmem_RRESP;
input   m_axi_gmem_BVALID;
output   m_axi_gmem_BREADY;
input  [1:0] m_axi_gmem_BRESP;
input  [0:0] m_axi_gmem_BID;
input  [0:0] m_axi_gmem_BUSER;
input  [63:0] p_read;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg toout17_read;
reg m_axi_gmem_AWVALID;
reg[63:0] m_axi_gmem_AWADDR;
reg[0:0] m_axi_gmem_AWID;
reg[31:0] m_axi_gmem_AWLEN;
reg[2:0] m_axi_gmem_AWSIZE;
reg[1:0] m_axi_gmem_AWBURST;
reg[1:0] m_axi_gmem_AWLOCK;
reg[3:0] m_axi_gmem_AWCACHE;
reg[2:0] m_axi_gmem_AWPROT;
reg[3:0] m_axi_gmem_AWQOS;
reg[3:0] m_axi_gmem_AWREGION;
reg[0:0] m_axi_gmem_AWUSER;
reg m_axi_gmem_WVALID;
reg m_axi_gmem_BREADY;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [10:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    gmem_blk_n_AW;
wire    ap_CS_fsm_state3;
wire   [0:0] icmp_ln1057_fu_109_p2;
reg    gmem_blk_n_B;
wire    ap_CS_fsm_state10;
wire   [27:0] sub_i_i_fu_99_p2;
wire    ap_CS_fsm_state2;
wire  signed [58:0] trunc_ln_fu_136_p4;
reg   [58:0] trunc_ln_reg_176;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_start;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_done;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_idle;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_ready;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWVALID;
wire   [63:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWADDR;
wire   [0:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWID;
wire   [31:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWLEN;
wire   [2:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWSIZE;
wire   [1:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWBURST;
wire   [1:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWLOCK;
wire   [3:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWCACHE;
wire   [2:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWPROT;
wire   [3:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWQOS;
wire   [3:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWREGION;
wire   [0:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWUSER;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WVALID;
wire   [255:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WDATA;
wire   [31:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WSTRB;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WLAST;
wire   [0:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WID;
wire   [0:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WUSER;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARVALID;
wire   [63:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARADDR;
wire   [0:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARID;
wire   [31:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARLEN;
wire   [2:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARSIZE;
wire   [1:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARBURST;
wire   [1:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARLOCK;
wire   [3:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARCACHE;
wire   [2:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARPROT;
wire   [3:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARQOS;
wire   [3:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARREGION;
wire   [0:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARUSER;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_RREADY;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_BREADY;
wire   [26:0] grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_sext_ln1057;
wire    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_toout17_read;
reg    grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_start_reg;
wire    ap_CS_fsm_state4;
wire    ap_CS_fsm_state5;
wire  signed [63:0] sext_ln59_fu_146_p1;
reg    ap_block_state3_io;
wire   [31:0] zext_ln59_fu_131_p1;
reg    ap_block_state10;
reg    ap_block_state1;
wire   [27:0] capturesize_cast_fu_95_p1;
wire   [25:0] tmp_2_fu_114_p4;
wire   [26:0] and_ln_fu_123_p3;
wire    ap_CS_fsm_state11;
reg   [10:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state2_blk;
reg    ap_ST_fsm_state3_blk;
wire    ap_ST_fsm_state4_blk;
reg    ap_ST_fsm_state5_blk;
wire    ap_ST_fsm_state6_blk;
wire    ap_ST_fsm_state7_blk;
wire    ap_ST_fsm_state8_blk;
wire    ap_ST_fsm_state9_blk;
reg    ap_ST_fsm_state10_blk;
wire    ap_ST_fsm_state11_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 11'd1;
#0 grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_start_reg = 1'b0;
end

iq_capture_put_data_csize_ap_uint_256_Pipeline_write grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_start),
    .ap_done(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_done),
    .ap_idle(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_idle),
    .ap_ready(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_ready),
    .m_axi_gmem_AWVALID(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWVALID),
    .m_axi_gmem_AWREADY(m_axi_gmem_AWREADY),
    .m_axi_gmem_AWADDR(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWADDR),
    .m_axi_gmem_AWID(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWID),
    .m_axi_gmem_AWLEN(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWLEN),
    .m_axi_gmem_AWSIZE(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWSIZE),
    .m_axi_gmem_AWBURST(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWBURST),
    .m_axi_gmem_AWLOCK(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWLOCK),
    .m_axi_gmem_AWCACHE(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWCACHE),
    .m_axi_gmem_AWPROT(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWPROT),
    .m_axi_gmem_AWQOS(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWQOS),
    .m_axi_gmem_AWREGION(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWREGION),
    .m_axi_gmem_AWUSER(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWUSER),
    .m_axi_gmem_WVALID(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WVALID),
    .m_axi_gmem_WREADY(m_axi_gmem_WREADY),
    .m_axi_gmem_WDATA(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WDATA),
    .m_axi_gmem_WSTRB(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WSTRB),
    .m_axi_gmem_WLAST(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WLAST),
    .m_axi_gmem_WID(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WID),
    .m_axi_gmem_WUSER(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WUSER),
    .m_axi_gmem_ARVALID(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARVALID),
    .m_axi_gmem_ARREADY(1'b0),
    .m_axi_gmem_ARADDR(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARADDR),
    .m_axi_gmem_ARID(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARID),
    .m_axi_gmem_ARLEN(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARLEN),
    .m_axi_gmem_ARSIZE(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARSIZE),
    .m_axi_gmem_ARBURST(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARBURST),
    .m_axi_gmem_ARLOCK(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARLOCK),
    .m_axi_gmem_ARCACHE(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARCACHE),
    .m_axi_gmem_ARPROT(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARPROT),
    .m_axi_gmem_ARQOS(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARQOS),
    .m_axi_gmem_ARREGION(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARREGION),
    .m_axi_gmem_ARUSER(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_ARUSER),
    .m_axi_gmem_RVALID(1'b0),
    .m_axi_gmem_RREADY(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_RREADY),
    .m_axi_gmem_RDATA(256'd0),
    .m_axi_gmem_RLAST(1'b0),
    .m_axi_gmem_RID(1'd0),
    .m_axi_gmem_RUSER(1'd0),
    .m_axi_gmem_RRESP(2'd0),
    .m_axi_gmem_BVALID(m_axi_gmem_BVALID),
    .m_axi_gmem_BREADY(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_BREADY),
    .m_axi_gmem_BRESP(m_axi_gmem_BRESP),
    .m_axi_gmem_BID(m_axi_gmem_BID),
    .m_axi_gmem_BUSER(m_axi_gmem_BUSER),
    .sext_ln59(trunc_ln_reg_176),
    .sext_ln1057(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_sext_ln1057),
    .toout17_dout(toout17_dout),
    .toout17_empty_n(toout17_empty_n),
    .toout17_read(grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_toout17_read)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if ((1'b1 == ap_CS_fsm_state11)) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_start_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_state4)) begin
            grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_start_reg <= 1'b1;
        end else if ((grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_ready == 1'b1)) begin
            grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_state3) & (icmp_ln1057_fu_109_p2 == 1'd1))) begin
        trunc_ln_reg_176 <= {{p_read[63:5]}};
    end
end

always @ (*) begin
    if (((m_axi_gmem_BVALID == 1'b0) & (icmp_ln1057_fu_109_p2 == 1'd1))) begin
        ap_ST_fsm_state10_blk = 1'b1;
    end else begin
        ap_ST_fsm_state10_blk = 1'b0;
    end
end

assign ap_ST_fsm_state11_blk = 1'b0;

always @ (*) begin
    if (((ap_done_reg == 1'b1) | (ap_start == 1'b0))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state2_blk = 1'b0;

always @ (*) begin
    if ((1'b1 == ap_block_state3_io)) begin
        ap_ST_fsm_state3_blk = 1'b1;
    end else begin
        ap_ST_fsm_state3_blk = 1'b0;
    end
end

assign ap_ST_fsm_state4_blk = 1'b0;

always @ (*) begin
    if ((grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_done == 1'b0)) begin
        ap_ST_fsm_state5_blk = 1'b1;
    end else begin
        ap_ST_fsm_state5_blk = 1'b0;
    end
end

assign ap_ST_fsm_state6_blk = 1'b0;

assign ap_ST_fsm_state7_blk = 1'b0;

assign ap_ST_fsm_state8_blk = 1'b0;

assign ap_ST_fsm_state9_blk = 1'b0;

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state11)) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state11)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state3) & (icmp_ln1057_fu_109_p2 == 1'd1))) begin
        gmem_blk_n_AW = m_axi_gmem_AWREADY;
    end else begin
        gmem_blk_n_AW = 1'b1;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state10) & (icmp_ln1057_fu_109_p2 == 1'd1))) begin
        gmem_blk_n_B = m_axi_gmem_BVALID;
    end else begin
        gmem_blk_n_B = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_state3_io) & (1'b1 == ap_CS_fsm_state3) & (icmp_ln1057_fu_109_p2 == 1'd1))) begin
        m_axi_gmem_AWADDR = sext_ln59_fu_146_p1;
    end else if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWADDR = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWADDR;
    end else begin
        m_axi_gmem_AWADDR = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWBURST = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWBURST;
    end else begin
        m_axi_gmem_AWBURST = 2'd0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWCACHE = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWCACHE;
    end else begin
        m_axi_gmem_AWCACHE = 4'd0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWID = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWID;
    end else begin
        m_axi_gmem_AWID = 1'd0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_state3_io) & (1'b1 == ap_CS_fsm_state3) & (icmp_ln1057_fu_109_p2 == 1'd1))) begin
        m_axi_gmem_AWLEN = zext_ln59_fu_131_p1;
    end else if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWLEN = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWLEN;
    end else begin
        m_axi_gmem_AWLEN = 'bx;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWLOCK = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWLOCK;
    end else begin
        m_axi_gmem_AWLOCK = 2'd0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWPROT = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWPROT;
    end else begin
        m_axi_gmem_AWPROT = 3'd0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWQOS = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWQOS;
    end else begin
        m_axi_gmem_AWQOS = 4'd0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWREGION = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWREGION;
    end else begin
        m_axi_gmem_AWREGION = 4'd0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWSIZE = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWSIZE;
    end else begin
        m_axi_gmem_AWSIZE = 3'd0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWUSER = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWUSER;
    end else begin
        m_axi_gmem_AWUSER = 1'd0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_state3_io) & (1'b1 == ap_CS_fsm_state3) & (icmp_ln1057_fu_109_p2 == 1'd1))) begin
        m_axi_gmem_AWVALID = 1'b1;
    end else if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_AWVALID = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_AWVALID;
    end else begin
        m_axi_gmem_AWVALID = 1'b0;
    end
end

always @ (*) begin
    if ((~((m_axi_gmem_BVALID == 1'b0) & (icmp_ln1057_fu_109_p2 == 1'd1)) & (1'b1 == ap_CS_fsm_state10) & (icmp_ln1057_fu_109_p2 == 1'd1))) begin
        m_axi_gmem_BREADY = 1'b1;
    end else if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_BREADY = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_BREADY;
    end else begin
        m_axi_gmem_BREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state4))) begin
        m_axi_gmem_WVALID = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WVALID;
    end else begin
        m_axi_gmem_WVALID = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state5)) begin
        toout17_read = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_toout17_read;
    end else begin
        toout17_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            ap_NS_fsm = ap_ST_fsm_state3;
        end
        ap_ST_fsm_state3 : begin
            if (((1'b0 == ap_block_state3_io) & (1'b1 == ap_CS_fsm_state3) & (icmp_ln1057_fu_109_p2 == 1'd0))) begin
                ap_NS_fsm = ap_ST_fsm_state10;
            end else if (((1'b0 == ap_block_state3_io) & (1'b1 == ap_CS_fsm_state3) & (icmp_ln1057_fu_109_p2 == 1'd1))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            ap_NS_fsm = ap_ST_fsm_state5;
        end
        ap_ST_fsm_state5 : begin
            if (((1'b1 == ap_CS_fsm_state5) & (grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_done == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state5;
            end
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state8;
        end
        ap_ST_fsm_state8 : begin
            ap_NS_fsm = ap_ST_fsm_state9;
        end
        ap_ST_fsm_state9 : begin
            ap_NS_fsm = ap_ST_fsm_state10;
        end
        ap_ST_fsm_state10 : begin
            if ((~((m_axi_gmem_BVALID == 1'b0) & (icmp_ln1057_fu_109_p2 == 1'd1)) & (1'b1 == ap_CS_fsm_state10))) begin
                ap_NS_fsm = ap_ST_fsm_state11;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state10;
            end
        end
        ap_ST_fsm_state11 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign and_ln_fu_123_p3 = {{tmp_2_fu_114_p4}, {1'd0}};

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state10 = ap_CS_fsm[32'd9];

assign ap_CS_fsm_state11 = ap_CS_fsm[32'd10];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];

always @ (*) begin
    ap_block_state1 = ((ap_done_reg == 1'b1) | (ap_start == 1'b0));
end

always @ (*) begin
    ap_block_state10 = ((m_axi_gmem_BVALID == 1'b0) & (icmp_ln1057_fu_109_p2 == 1'd1));
end

always @ (*) begin
    ap_block_state3_io = ((m_axi_gmem_AWREADY == 1'b0) & (icmp_ln1057_fu_109_p2 == 1'd1));
end

assign capturesize_cast_fu_95_p1 = capturesize;

assign grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_start = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_ap_start_reg;

assign grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_sext_ln1057 = sub_i_i_fu_99_p2[26:0];

assign icmp_ln1057_fu_109_p2 = (($signed(sub_i_i_fu_99_p2) > $signed(28'd0)) ? 1'b1 : 1'b0);

assign m_axi_gmem_ARADDR = 64'd0;

assign m_axi_gmem_ARBURST = 2'd0;

assign m_axi_gmem_ARCACHE = 4'd0;

assign m_axi_gmem_ARID = 1'd0;

assign m_axi_gmem_ARLEN = 32'd0;

assign m_axi_gmem_ARLOCK = 2'd0;

assign m_axi_gmem_ARPROT = 3'd0;

assign m_axi_gmem_ARQOS = 4'd0;

assign m_axi_gmem_ARREGION = 4'd0;

assign m_axi_gmem_ARSIZE = 3'd0;

assign m_axi_gmem_ARUSER = 1'd0;

assign m_axi_gmem_ARVALID = 1'b0;

assign m_axi_gmem_RREADY = 1'b0;

assign m_axi_gmem_WDATA = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WDATA;

assign m_axi_gmem_WID = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WID;

assign m_axi_gmem_WLAST = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WLAST;

assign m_axi_gmem_WSTRB = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WSTRB;

assign m_axi_gmem_WUSER = grp_put_data_csize_ap_uint_256_Pipeline_write_fu_85_m_axi_gmem_WUSER;

assign sext_ln59_fu_146_p1 = trunc_ln_fu_136_p4;

assign sub_i_i_fu_99_p2 = ($signed(capturesize_cast_fu_95_p1) + $signed(28'd268435455));

assign tmp_2_fu_114_p4 = {{capturesize[26:1]}};

assign trunc_ln_fu_136_p4 = {{p_read[63:5]}};

assign zext_ln59_fu_131_p1 = and_ln_fu_123_p3;

endmodule //iq_capture_put_data_csize_ap_uint_256_s
