// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module iq_capture_capture_data_ap_uint_256_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        fetched16_dout,
        fetched16_empty_n,
        fetched16_read,
        fetched_keep18_dout,
        fetched_keep18_empty_n,
        fetched_keep18_read,
        capturesize,
        toout17_din,
        toout17_full_n,
        toout17_write
);

parameter    ap_ST_fsm_state1 = 5'd1;
parameter    ap_ST_fsm_pp0_stage0 = 5'd2;
parameter    ap_ST_fsm_pp0_stage1 = 5'd4;
parameter    ap_ST_fsm_state6 = 5'd8;
parameter    ap_ST_fsm_state7 = 5'd16;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [255:0] fetched16_dout;
input   fetched16_empty_n;
output   fetched16_read;
input  [0:0] fetched_keep18_dout;
input   fetched_keep18_empty_n;
output   fetched_keep18_read;
input  [34:0] capturesize;
output  [255:0] toout17_din;
input   toout17_full_n;
output   toout17_write;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg fetched16_read;
reg fetched_keep18_read;
reg toout17_write;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [4:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    fetched16_blk_n;
wire    ap_CS_fsm_pp0_stage1;
reg    ap_enable_reg_pp0_iter0;
wire    ap_block_pp0_stage1;
reg   [0:0] icmp_ln1057_reg_123;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter1;
wire    ap_block_pp0_stage0;
reg    fetched_keep18_blk_n;
reg    toout17_blk_n;
reg   [0:0] tmp_reg_132;
reg   [0:0] tmp_7_reg_136;
reg   [255:0] reg_69;
reg    ap_block_state3_pp0_stage1_iter0;
reg    ap_block_state5_pp0_stage1_iter1;
reg    ap_block_pp0_stage1_11001;
wire    ap_block_state2_pp0_stage0_iter0;
reg    ap_block_state4_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
wire   [35:0] sub_i_i_fu_78_p2;
wire   [0:0] icmp_ln1057_fu_96_p2;
wire   [31:0] i_fu_101_p2;
reg   [31:0] i_reg_127;
reg    ap_block_state1;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_pp0_exit_iter0_state2;
reg    ap_block_pp0_stage1_subdone;
reg   [31:0] i_2_fu_40;
reg    ap_block_pp0_stage0_01001;
reg    ap_block_pp0_stage1_01001;
wire   [35:0] capturesize_cast_fu_74_p1;
wire  signed [31:0] sext_ln1057_fu_92_p0;
wire  signed [35:0] sext_ln1057_fu_92_p1;
wire  signed [31:0] i_fu_101_p0;
wire    ap_CS_fsm_state7;
reg   [4:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ST_fsm_state6_blk;
wire    ap_ST_fsm_state7_blk;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 5'd1;
#0 ap_enable_reg_pp0_iter0 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

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
        end else if ((1'b1 == ap_CS_fsm_state7)) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b1 == ap_condition_pp0_exit_iter0_state2))) begin
            ap_enable_reg_pp0_iter0 <= 1'b0;
        end else if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter0 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage1_subdone) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end else if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        i_2_fu_40 <= 32'd0;
    end else if (((icmp_ln1057_reg_123 == 1'd1) & (1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        i_2_fu_40 <= i_reg_127;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (icmp_ln1057_fu_96_p2 == 1'd1))) begin
        i_reg_127 <= i_fu_101_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln1057_reg_123 <= icmp_ln1057_fu_96_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((icmp_ln1057_reg_123 == 1'd1) & (1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)))) begin
        reg_69 <= fetched16_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_7_reg_136 <= fetched_keep18_dout;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln1057_reg_123 == 1'd1) & (1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        tmp_reg_132 <= fetched_keep18_dout;
    end
end

always @ (*) begin
    if (((ap_done_reg == 1'b1) | (ap_start == 1'b0))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

assign ap_ST_fsm_state6_blk = 1'b0;

assign ap_ST_fsm_state7_blk = 1'b0;

always @ (*) begin
    if ((icmp_ln1057_fu_96_p2 == 1'd0)) begin
        ap_condition_pp0_exit_iter0_state2 = 1'b1;
    end else begin
        ap_condition_pp0_exit_iter0_state2 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
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
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state7)) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((icmp_ln1057_reg_123 == 1'd1) & (1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)))) begin
        fetched16_blk_n = fetched16_empty_n;
    end else begin
        fetched16_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((icmp_ln1057_reg_123 == 1'd1) & (1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)))) begin
        fetched16_read = 1'b1;
    end else begin
        fetched16_read = 1'b0;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((icmp_ln1057_reg_123 == 1'd1) & (1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)))) begin
        fetched_keep18_blk_n = fetched_keep18_empty_n;
    end else begin
        fetched_keep18_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((icmp_ln1057_reg_123 == 1'd1) & (1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)))) begin
        fetched_keep18_read = 1'b1;
    end else begin
        fetched_keep18_read = 1'b0;
    end
end

always @ (*) begin
    if ((((tmp_7_reg_136 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage1) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((tmp_reg_132 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        toout17_blk_n = toout17_full_n;
    end else begin
        toout17_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((tmp_7_reg_136 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((tmp_reg_132 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        toout17_write = 1'b1;
    end else begin
        toout17_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_done_reg == 1'b1) | (ap_start == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (icmp_ln1057_fu_96_p2 == 1'd0)) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end else if (((ap_enable_reg_pp0_iter1 == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (icmp_ln1057_fu_96_p2 == 1'd0))) begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_pp0_stage1 : begin
            if ((~((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage1_subdone) & (ap_enable_reg_pp0_iter0 == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage1)) & (1'b0 == ap_block_pp0_stage1_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if (((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage1_subdone) & (ap_enable_reg_pp0_iter0 == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
                ap_NS_fsm = ap_ST_fsm_state6;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end
        end
        ap_ST_fsm_state6 : begin
            ap_NS_fsm = ap_ST_fsm_state7;
        end
        ap_ST_fsm_state7 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_pp0_stage1 = ap_CS_fsm[32'd2];

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state7 = ap_CS_fsm[32'd4];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_enable_reg_pp0_iter1 == 1'b1) & ((fetched_keep18_empty_n == 1'b0) | (fetched16_empty_n == 1'b0) | ((tmp_reg_132 == 1'd1) & (toout17_full_n == 1'b0))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_enable_reg_pp0_iter1 == 1'b1) & ((fetched_keep18_empty_n == 1'b0) | (fetched16_empty_n == 1'b0) | ((tmp_reg_132 == 1'd1) & (toout17_full_n == 1'b0))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_enable_reg_pp0_iter1 == 1'b1) & ((fetched_keep18_empty_n == 1'b0) | (fetched16_empty_n == 1'b0) | ((tmp_reg_132 == 1'd1) & (toout17_full_n == 1'b0))));
end

assign ap_block_pp0_stage1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage1_01001 = (((tmp_7_reg_136 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (toout17_full_n == 1'b0)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & (((icmp_ln1057_reg_123 == 1'd1) & (fetched_keep18_empty_n == 1'b0)) | ((icmp_ln1057_reg_123 == 1'd1) & (fetched16_empty_n == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage1_11001 = (((tmp_7_reg_136 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (toout17_full_n == 1'b0)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & (((icmp_ln1057_reg_123 == 1'd1) & (fetched_keep18_empty_n == 1'b0)) | ((icmp_ln1057_reg_123 == 1'd1) & (fetched16_empty_n == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage1_subdone = (((tmp_7_reg_136 == 1'd1) & (ap_enable_reg_pp0_iter1 == 1'b1) & (toout17_full_n == 1'b0)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & (((icmp_ln1057_reg_123 == 1'd1) & (fetched_keep18_empty_n == 1'b0)) | ((icmp_ln1057_reg_123 == 1'd1) & (fetched16_empty_n == 1'b0)))));
end

always @ (*) begin
    ap_block_state1 = ((ap_done_reg == 1'b1) | (ap_start == 1'b0));
end

assign ap_block_state2_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_pp0_stage1_iter0 = (((icmp_ln1057_reg_123 == 1'd1) & (fetched_keep18_empty_n == 1'b0)) | ((icmp_ln1057_reg_123 == 1'd1) & (fetched16_empty_n == 1'b0)));
end

always @ (*) begin
    ap_block_state4_pp0_stage0_iter1 = ((fetched_keep18_empty_n == 1'b0) | (fetched16_empty_n == 1'b0) | ((tmp_reg_132 == 1'd1) & (toout17_full_n == 1'b0)));
end

always @ (*) begin
    ap_block_state5_pp0_stage1_iter1 = ((tmp_7_reg_136 == 1'd1) & (toout17_full_n == 1'b0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign capturesize_cast_fu_74_p1 = capturesize;

assign i_fu_101_p0 = i_2_fu_40;

assign i_fu_101_p2 = ($signed(i_fu_101_p0) + $signed(32'd2));

assign icmp_ln1057_fu_96_p2 = (($signed(sext_ln1057_fu_92_p1) < $signed(sub_i_i_fu_78_p2)) ? 1'b1 : 1'b0);

assign sext_ln1057_fu_92_p0 = i_2_fu_40;

assign sext_ln1057_fu_92_p1 = sext_ln1057_fu_92_p0;

assign sub_i_i_fu_78_p2 = ($signed(capturesize_cast_fu_74_p1) + $signed(36'd68719476735));

assign toout17_din = reg_69;

endmodule //iq_capture_capture_data_ap_uint_256_s