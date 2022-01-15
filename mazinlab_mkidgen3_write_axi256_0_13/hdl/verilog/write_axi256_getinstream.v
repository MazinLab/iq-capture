// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module write_axi256_getinstream (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        buf8_din,
        buf8_full_n,
        buf8_write,
        filtered_TVALID,
        filtered_TDATA,
        filtered_TREADY,
        filtered_TKEEP,
        filtered_TSTRB,
        filtered_TLAST,
        capturesize
);

parameter    ap_ST_fsm_pp0_stage0 = 2'd1;
parameter    ap_ST_fsm_pp0_stage1 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output  [255:0] buf8_din;
input   buf8_full_n;
output   buf8_write;
input   filtered_TVALID;
input  [255:0] filtered_TDATA;
output   filtered_TREADY;
input  [31:0] filtered_TKEEP;
input  [31:0] filtered_TSTRB;
input  [0:0] filtered_TLAST;
input  [26:0] capturesize;

reg ap_idle;
reg buf8_write;

(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
wire    ap_CS_fsm_pp0_stage1;
reg   [0:0] sync_reg_83;
reg    ap_block_state2_pp0_stage1_iter0;
reg    ap_done_reg;
reg    ap_block_pp0_stage1_subdone;
wire   [0:0] done_1_fu_193_p3;
reg    ap_condition_exit_pp0_iter0_stage1;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    filtered_TDATA_blk_n;
wire    ap_block_pp0_stage0;
wire    ap_block_pp0_stage1;
reg    buf8_blk_n;
reg   [0:0] and_ln188_reg_265;
reg   [255:0] reg_102;
reg    ap_block_state1_pp0_stage0_iter0;
reg    ap_block_state3_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_11001;
reg    ap_block_pp0_stage1_11001;
reg   [0:0] tmp_4_reg_232;
wire   [0:0] icmp_ln188_fu_135_p2;
reg   [0:0] icmp_ln188_reg_240;
wire   [0:0] icmp_ln194_fu_144_p2;
reg   [0:0] icmp_ln194_reg_245;
wire   [31:0] count_1_fu_150_p2;
reg   [31:0] count_1_reg_250;
wire   [0:0] done_2_fu_156_p2;
reg   [0:0] done_2_reg_255;
wire   [31:0] count_3_fu_162_p2;
reg   [31:0] count_3_reg_260;
wire   [0:0] and_ln188_fu_173_p2;
reg   [0:0] done_1_reg_269;
wire   [0:0] sync_1_fu_213_p2;
reg   [0:0] sync_1_reg_273;
reg    ap_enable_reg_pp0_iter0_reg;
reg    ap_block_pp0_stage0_subdone;
reg    ap_condition_exit_pp0_iter1_stage0;
reg    ap_idle_pp0_0to0;
wire    ap_loop_init;
reg   [31:0] count_fu_54;
wire   [31:0] count_2_fu_201_p3;
reg   [31:0] ap_sig_allocacmp_count_load_1;
reg   [31:0] ap_sig_allocacmp_count_load;
reg    ap_block_pp0_stage1_01001;
reg    ap_block_pp0_stage0_01001;
wire   [26:0] sub_fu_107_p2;
wire   [26:0] sub8_fu_117_p2;
wire   [31:0] sub_cast_fu_113_p1;
wire   [31:0] zext_ln179_fu_123_p1;
wire   [0:0] or_ln188_fu_168_p2;
wire   [0:0] done_fu_178_p2;
wire   [0:0] done_3_fu_183_p2;
wire   [31:0] count_4_fu_187_p3;
wire   [0:0] or_ln205_fu_208_p2;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg   [1:0] ap_NS_fsm;
reg    ap_idle_pp0_1to1;
reg    ap_done_pending_pp0;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    regslice_both_filtered_V_data_V_U_apdone_blk;
wire   [255:0] filtered_TDATA_int_regslice;
wire    filtered_TVALID_int_regslice;
reg    filtered_TREADY_int_regslice;
wire    regslice_both_filtered_V_data_V_U_ack_in;
wire    regslice_both_filtered_V_keep_V_U_apdone_blk;
wire   [31:0] filtered_TKEEP_int_regslice;
wire    regslice_both_filtered_V_keep_V_U_vld_out;
wire    regslice_both_filtered_V_keep_V_U_ack_in;
wire    regslice_both_filtered_V_strb_V_U_apdone_blk;
wire   [31:0] filtered_TSTRB_int_regslice;
wire    regslice_both_filtered_V_strb_V_U_vld_out;
wire    regslice_both_filtered_V_strb_V_U_ack_in;
wire    regslice_both_filtered_V_last_V_U_apdone_blk;
wire   [0:0] filtered_TLAST_int_regslice;
wire    regslice_both_filtered_V_last_V_U_vld_out;
wire    regslice_both_filtered_V_last_V_U_ack_in;
reg    ap_condition_344;
reg    ap_condition_347;
reg    ap_condition_352;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 2'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_done_reg = 1'b0;
#0 ap_enable_reg_pp0_iter0_reg = 1'b0;
end

write_axi256_flow_control_loop_pipe flow_control_loop_pipe_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage1),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int),
    .ap_continue(ap_continue)
);

write_axi256_regslice_both #(
    .DataWidth( 256 ))
regslice_both_filtered_V_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(filtered_TDATA),
    .vld_in(filtered_TVALID),
    .ack_in(regslice_both_filtered_V_data_V_U_ack_in),
    .data_out(filtered_TDATA_int_regslice),
    .vld_out(filtered_TVALID_int_regslice),
    .ack_out(filtered_TREADY_int_regslice),
    .apdone_blk(regslice_both_filtered_V_data_V_U_apdone_blk)
);

write_axi256_regslice_both #(
    .DataWidth( 32 ))
regslice_both_filtered_V_keep_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(filtered_TKEEP),
    .vld_in(filtered_TVALID),
    .ack_in(regslice_both_filtered_V_keep_V_U_ack_in),
    .data_out(filtered_TKEEP_int_regslice),
    .vld_out(regslice_both_filtered_V_keep_V_U_vld_out),
    .ack_out(filtered_TREADY_int_regslice),
    .apdone_blk(regslice_both_filtered_V_keep_V_U_apdone_blk)
);

write_axi256_regslice_both #(
    .DataWidth( 32 ))
regslice_both_filtered_V_strb_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(filtered_TSTRB),
    .vld_in(filtered_TVALID),
    .ack_in(regslice_both_filtered_V_strb_V_U_ack_in),
    .data_out(filtered_TSTRB_int_regslice),
    .vld_out(regslice_both_filtered_V_strb_V_U_vld_out),
    .ack_out(filtered_TREADY_int_regslice),
    .apdone_blk(regslice_both_filtered_V_strb_V_U_apdone_blk)
);

write_axi256_regslice_both #(
    .DataWidth( 1 ))
regslice_both_filtered_V_last_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(filtered_TLAST),
    .vld_in(filtered_TVALID),
    .ack_in(regslice_both_filtered_V_last_V_U_ack_in),
    .data_out(filtered_TLAST_int_regslice),
    .vld_out(regslice_both_filtered_V_last_V_U_vld_out),
    .ack_out(filtered_TREADY_int_regslice),
    .apdone_blk(regslice_both_filtered_V_last_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
            ap_enable_reg_pp0_iter0_reg <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((((1'b1 == ap_condition_exit_pp0_iter1_stage0) & (ap_idle_pp0_0to0 == 1'b1)) | ((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage1_subdone) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((((ap_loop_exit_ready == 1'b0) & (1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0)) | ((1'b1 == ap_condition_exit_pp0_iter1_stage0) & (ap_idle_pp0_0to0 == 1'b1)))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= 1'b0;
    end else if (((1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
    end
end

always @ (posedge ap_clk) begin
    if ((ap_enable_reg_pp0_iter0 == 1'b1)) begin
        if ((1'b1 == ap_condition_347)) begin
            count_fu_54 <= 32'd0;
        end else if ((1'b1 == ap_condition_344)) begin
            count_fu_54 <= count_2_fu_201_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
        if ((1'b1 == ap_condition_352)) begin
            sync_reg_83 <= sync_1_reg_273;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_init == 1'b1))) begin
            sync_reg_83 <= 1'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        and_ln188_reg_265 <= and_ln188_fu_173_p2;
        done_1_reg_269 <= done_1_fu_193_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        count_1_reg_250 <= count_1_fu_150_p2;
        count_3_reg_260 <= count_3_fu_162_p2;
        done_2_reg_255 <= done_2_fu_156_p2;
        icmp_ln188_reg_240 <= icmp_ln188_fu_135_p2;
        icmp_ln194_reg_245 <= icmp_ln194_fu_144_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((((1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        reg_102 <= filtered_TDATA_int_regslice;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        sync_1_reg_273 <= sync_1_fu_213_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        tmp_4_reg_232 <= filtered_TLAST_int_regslice;
    end
end

always @ (*) begin
    if (((done_1_fu_193_p3 == 1'd1) & (1'b0 == ap_block_pp0_stage1_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        ap_condition_exit_pp0_iter0_stage1 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (done_1_reg_269 == 1'd1))) begin
        ap_condition_exit_pp0_iter1_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter1_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (~((ap_loop_exit_ready == 1'b0) & (ap_loop_exit_ready_pp0_iter1_reg == 1'b0))) begin
        ap_done_pending_pp0 = 1'b1;
    end else begin
        ap_done_pending_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
        ap_enable_reg_pp0_iter0 = ap_start_int;
    end else begin
        ap_enable_reg_pp0_iter0 = ap_enable_reg_pp0_iter0_reg;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
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
    if ((ap_enable_reg_pp0_iter0 == 1'b0)) begin
        ap_idle_pp0_0to0 = 1'b1;
    end else begin
        ap_idle_pp0_0to0 = 1'b0;
    end
end

always @ (*) begin
    if ((ap_enable_reg_pp0_iter1 == 1'b0)) begin
        ap_idle_pp0_1to1 = 1'b1;
    end else begin
        ap_idle_pp0_1to1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_count_load = 32'd0;
    end else begin
        ap_sig_allocacmp_count_load = count_fu_54;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_count_load_1 = 32'd0;
    end else begin
        ap_sig_allocacmp_count_load_1 = count_fu_54;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage1) & (sync_reg_83 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((1'b0 == ap_block_pp0_stage0) & (1'd1 == and_ln188_reg_265) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        buf8_blk_n = buf8_full_n;
    end else begin
        buf8_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage1_11001) & (sync_reg_83 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (1'd1 == and_ln188_reg_265) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        buf8_write = 1'b1;
    end else begin
        buf8_write = 1'b0;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((1'b0 == ap_block_pp0_stage0) & (ap_done_reg == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        filtered_TDATA_blk_n = filtered_TVALID_int_regslice;
    end else begin
        filtered_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((((1'b0 == ap_block_pp0_stage1_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1)) | ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
        filtered_TREADY_int_regslice = 1'b1;
    end else begin
        filtered_TREADY_int_regslice = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            if (((1'b1 == ap_condition_exit_pp0_iter1_stage0) & (ap_idle_pp0_0to0 == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else if ((~((ap_start_int == 1'b0) & (ap_done_pending_pp0 == 1'b0) & (ap_idle_pp0_1to1 == 1'b1)) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_pp0_stage1 : begin
            if ((1'b0 == ap_block_pp0_stage1_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign and_ln188_fu_173_p2 = (or_ln188_fu_168_p2 & icmp_ln188_reg_240);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_pp0_stage1 = ap_CS_fsm[32'd1];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((1'd1 == and_ln188_reg_265) & (buf8_full_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & ((ap_done_reg == 1'b1) | (filtered_TVALID_int_regslice == 1'b0))));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((1'd1 == and_ln188_reg_265) & (buf8_full_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & ((ap_done_reg == 1'b1) | (filtered_TVALID_int_regslice == 1'b0))));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((1'd1 == and_ln188_reg_265) & (buf8_full_n == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b1)) | ((ap_enable_reg_pp0_iter0 == 1'b1) & ((ap_done_reg == 1'b1) | (filtered_TVALID_int_regslice == 1'b0))));
end

assign ap_block_pp0_stage1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage1_01001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter0 == 1'b1) & ((filtered_TVALID_int_regslice == 1'b0) | ((sync_reg_83 == 1'd1) & (buf8_full_n == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage1_11001 = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter0 == 1'b1) & ((filtered_TVALID_int_regslice == 1'b0) | ((sync_reg_83 == 1'd1) & (buf8_full_n == 1'b0)))));
end

always @ (*) begin
    ap_block_pp0_stage1_subdone = ((ap_done_reg == 1'b1) | ((ap_enable_reg_pp0_iter0 == 1'b1) & ((filtered_TVALID_int_regslice == 1'b0) | ((sync_reg_83 == 1'd1) & (buf8_full_n == 1'b0)))));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = ((ap_done_reg == 1'b1) | (filtered_TVALID_int_regslice == 1'b0));
end

always @ (*) begin
    ap_block_state2_pp0_stage1_iter0 = ((filtered_TVALID_int_regslice == 1'b0) | ((sync_reg_83 == 1'd1) & (buf8_full_n == 1'b0)));
end

always @ (*) begin
    ap_block_state3_pp0_stage0_iter1 = ((1'd1 == and_ln188_reg_265) & (buf8_full_n == 1'b0));
end

always @ (*) begin
    ap_condition_344 = ((done_1_fu_193_p3 == 1'd0) & (1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1));
end

always @ (*) begin
    ap_condition_347 = ((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1));
end

always @ (*) begin
    ap_condition_352 = ((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (done_1_reg_269 == 1'd0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage1;

assign buf8_din = reg_102;

assign count_1_fu_150_p2 = (ap_sig_allocacmp_count_load + 32'd2);

assign count_2_fu_201_p3 = ((sync_reg_83[0:0] == 1'b1) ? count_1_reg_250 : count_4_fu_187_p3);

assign count_3_fu_162_p2 = (ap_sig_allocacmp_count_load + 32'd1);

assign count_4_fu_187_p3 = ((tmp_4_reg_232[0:0] == 1'b1) ? count_3_reg_260 : 32'd0);

assign done_1_fu_193_p3 = ((sync_reg_83[0:0] == 1'b1) ? done_fu_178_p2 : done_3_fu_183_p2);

assign done_2_fu_156_p2 = ((ap_sig_allocacmp_count_load == 32'd1) ? 1'b1 : 1'b0);

assign done_3_fu_183_p2 = (tmp_4_reg_232 & done_2_reg_255);

assign done_fu_178_p2 = (icmp_ln194_reg_245 ^ 1'd1);

assign filtered_TREADY = regslice_both_filtered_V_data_V_U_ack_in;

assign icmp_ln188_fu_135_p2 = (($signed(ap_sig_allocacmp_count_load_1) < $signed(sub_cast_fu_113_p1)) ? 1'b1 : 1'b0);

assign icmp_ln194_fu_144_p2 = (($signed(ap_sig_allocacmp_count_load) < $signed(zext_ln179_fu_123_p1)) ? 1'b1 : 1'b0);

assign or_ln188_fu_168_p2 = (tmp_4_reg_232 | sync_reg_83);

assign or_ln205_fu_208_p2 = (tmp_4_reg_232 | filtered_TLAST_int_regslice);

assign sub8_fu_117_p2 = ($signed(capturesize) + $signed(27'd134217726));

assign sub_cast_fu_113_p1 = sub_fu_107_p2;

assign sub_fu_107_p2 = ($signed(capturesize) + $signed(27'd134217727));

assign sync_1_fu_213_p2 = (sync_reg_83 | or_ln205_fu_208_p2);

assign zext_ln179_fu_123_p1 = sub8_fu_117_p2;

endmodule //write_axi256_getinstream
