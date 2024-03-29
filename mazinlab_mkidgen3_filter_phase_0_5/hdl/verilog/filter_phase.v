// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="filter_phase_filter_phase,hls_ip_2021_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu21dr-ffvd1156-1-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=1.000000,HLS_SYN_LAT=3,HLS_SYN_TPT=4,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=390,HLS_SYN_LUT=380,HLS_VERSION=2021_1}" *)

module filter_phase (
// synthesis translate_off
    kernel_block,
// synthesis translate_on
        ap_clk,
        ap_rst_n,
        instream_TDATA,
        instream_TVALID,
        instream_TREADY,
        instream_TKEEP,
        instream_TSTRB,
        instream_TUSER,
        instream_TLAST,
        outstream_TDATA,
        outstream_TVALID,
        outstream_TREADY,
        outstream_TKEEP,
        outstream_TSTRB,
        outstream_TLAST,
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
        s_axi_control_BRESP
);

parameter    ap_ST_fsm_state1 = 4'd1;
parameter    ap_ST_fsm_state2 = 4'd2;
parameter    ap_ST_fsm_state3 = 4'd4;
parameter    ap_ST_fsm_state4 = 4'd8;
parameter    C_S_AXI_CONTROL_DATA_WIDTH = 32;
parameter    C_S_AXI_CONTROL_ADDR_WIDTH = 6;
parameter    C_S_AXI_DATA_WIDTH = 32;

parameter C_S_AXI_CONTROL_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);

// synthesis translate_off
output kernel_block;
// synthesis translate_on
input   ap_clk;
input   ap_rst_n;
input  [63:0] instream_TDATA;
input   instream_TVALID;
output   instream_TREADY;
input  [7:0] instream_TKEEP;
input  [7:0] instream_TSTRB;
input  [15:0] instream_TUSER;
input  [0:0] instream_TLAST;
output  [255:0] outstream_TDATA;
output   outstream_TVALID;
input   outstream_TREADY;
output  [31:0] outstream_TKEEP;
output  [31:0] outstream_TSTRB;
output  [0:0] outstream_TLAST;
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

reg instream_TREADY;
reg outstream_TVALID;

 reg    ap_rst_n_inv;
wire   [127:0] keep;
wire   [6:0] lastgrp;
reg    instream_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
wire    ap_CS_fsm_state2;
reg   [0:0] p_aligne_reg_180;
wire    ap_CS_fsm_state3;
wire    ap_CS_fsm_state4;
reg    outstream_TDATA_blk_n;
reg   [0:0] p_keep_reg_189;
reg   [6:0] lastgrp_read_reg_170;
reg   [63:0] tmp_3_reg_175;
wire   [0:0] p_aligne_fu_139_p2;
reg   [6:0] grp_V_reg_184;
wire   [0:0] p_keep_fetch_keep_fu_120_ap_return;
reg   [63:0] tmp_5_reg_193;
wire   [0:0] tmp_last_V_fu_156_p2;
reg   [0:0] tmp_last_V_reg_198;
reg   [63:0] tmp_6_reg_203;
wire    p_keep_fetch_keep_fu_120_ap_ready;
wire   [6:0] p_keep_fetch_keep_fu_120_grp;
reg    ap_block_state2;
reg    ap_block_state3;
reg    ap_predicate_op44_write_state4;
reg    ap_block_state4;
reg    ap_block_state4_io;
wire   [1:0] trunc_ln674_fu_135_p1;
reg   [3:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
reg    ap_ST_fsm_state2_blk;
reg    ap_ST_fsm_state3_blk;
reg    ap_ST_fsm_state4_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 4'd1;
end

filter_phase_fetch_keep p_keep_fetch_keep_fu_120(
    .ap_ready(p_keep_fetch_keep_fu_120_ap_ready),
    .keep(keep),
    .grp(p_keep_fetch_keep_fu_120_grp),
    .ap_return(p_keep_fetch_keep_fu_120_ap_return)
);

filter_phase_control_s_axi #(
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
    .lastgrp(lastgrp)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        grp_V_reg_184 <= {{instream_TUSER[8:2]}};
        lastgrp_read_reg_170 <= lastgrp;
        p_aligne_reg_180 <= p_aligne_fu_139_p2;
        p_keep_reg_189 <= p_keep_fetch_keep_fu_120_ap_return;
        tmp_3_reg_175 <= instream_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((p_aligne_reg_180 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
        tmp_5_reg_193 <= instream_TDATA;
        tmp_last_V_reg_198 <= tmp_last_V_fu_156_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((p_aligne_reg_180 == 1'd1) & (1'b1 == ap_CS_fsm_state3))) begin
        tmp_6_reg_203 <= instream_TDATA;
    end
end

always @ (*) begin
    if ((instream_TVALID == 1'b0)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if (((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0))) begin
        ap_ST_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_fsm_state2_blk = 1'b0;
    end
end

always @ (*) begin
    if (((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0))) begin
        ap_ST_fsm_state3_blk = 1'b1;
    end else begin
        ap_ST_fsm_state3_blk = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_block_state4_io) | ((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0)) | ((outstream_TREADY == 1'b0) & (ap_predicate_op44_write_state4 == 1'b1)))) begin
        ap_ST_fsm_state4_blk = 1'b1;
    end else begin
        ap_ST_fsm_state4_blk = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state1) | ((p_aligne_reg_180 == 1'd1) & (1'b1 == ap_CS_fsm_state4)) | ((p_aligne_reg_180 == 1'd1) & (1'b1 == ap_CS_fsm_state3)) | ((p_aligne_reg_180 == 1'd1) & (1'b1 == ap_CS_fsm_state2)))) begin
        instream_TDATA_blk_n = instream_TVALID;
    end else begin
        instream_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((1'b1 == ap_CS_fsm_state1) & (instream_TVALID == 1'b1)) | (~((1'b1 == ap_block_state4_io) | ((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0)) | ((outstream_TREADY == 1'b0) & (ap_predicate_op44_write_state4 == 1'b1))) & (p_aligne_reg_180 == 1'd1) & (1'b1 == ap_CS_fsm_state4)) | (~((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0)) & (p_aligne_reg_180 == 1'd1) & (1'b1 == ap_CS_fsm_state3)) | (~((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0)) & (p_aligne_reg_180 == 1'd1) & (1'b1 == ap_CS_fsm_state2)))) begin
        instream_TREADY = 1'b1;
    end else begin
        instream_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((p_keep_reg_189 == 1'd1) & (p_aligne_reg_180 == 1'd1) & (1'b1 == ap_CS_fsm_state4))) begin
        outstream_TDATA_blk_n = outstream_TREADY;
    end else begin
        outstream_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((1'b1 == ap_block_state4_io) | ((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0)) | ((outstream_TREADY == 1'b0) & (ap_predicate_op44_write_state4 == 1'b1))) & (1'b1 == ap_CS_fsm_state4) & (ap_predicate_op44_write_state4 == 1'b1))) begin
        outstream_TVALID = 1'b1;
    end else begin
        outstream_TVALID = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (instream_TVALID == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if ((~((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0)) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        ap_ST_fsm_state3 : begin
            if ((~((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0)) & (1'b1 == ap_CS_fsm_state3))) begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        ap_ST_fsm_state4 : begin
            if ((~((1'b1 == ap_block_state4_io) | ((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0)) | ((outstream_TREADY == 1'b0) & (ap_predicate_op44_write_state4 == 1'b1))) & (1'b1 == ap_CS_fsm_state4))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state4;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];

always @ (*) begin
    ap_block_state2 = ((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0));
end

always @ (*) begin
    ap_block_state3 = ((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0));
end

always @ (*) begin
    ap_block_state4 = (((p_aligne_reg_180 == 1'd1) & (instream_TVALID == 1'b0)) | ((outstream_TREADY == 1'b0) & (ap_predicate_op44_write_state4 == 1'b1)));
end

always @ (*) begin
    ap_block_state4_io = ((outstream_TREADY == 1'b0) & (ap_predicate_op44_write_state4 == 1'b1));
end

always @ (*) begin
    ap_predicate_op44_write_state4 = ((p_keep_reg_189 == 1'd1) & (p_aligne_reg_180 == 1'd1));
end

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign outstream_TDATA = {{{{instream_TDATA}, {tmp_6_reg_203}}, {tmp_5_reg_193}}, {tmp_3_reg_175}};

assign outstream_TKEEP = 32'd4294967295;

assign outstream_TLAST = tmp_last_V_reg_198;

assign outstream_TSTRB = 32'd0;

assign p_aligne_fu_139_p2 = ((trunc_ln674_fu_135_p1 == 2'd0) ? 1'b1 : 1'b0);

assign p_keep_fetch_keep_fu_120_grp = {{instream_TUSER[8:2]}};

assign tmp_last_V_fu_156_p2 = ((grp_V_reg_184 == lastgrp_read_reg_170) ? 1'b1 : 1'b0);

assign trunc_ln674_fu_135_p1 = instream_TUSER[1:0];


// synthesis translate_off
`include "filter_phase_hls_deadlock_kernel_monitor_top.vh"
// synthesis translate_on

endmodule //filter_phase

