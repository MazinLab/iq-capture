// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="pair_iq_pair_iq,hls_ip_2021_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu21dr-ffvd1156-1-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=0.907000,HLS_SYN_LAT=0,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=9,HLS_SYN_LUT=55,HLS_VERSION=2021_1}" *)

module pair_iq (
// synthesis translate_off
    kernel_block,
// synthesis translate_on
        ap_clk,
        ap_rst_n,
        i_in_V_TDATA,
        i_in_V_TVALID,
        i_in_V_TREADY,
        q_in_V_TDATA,
        q_in_V_TVALID,
        q_in_V_TREADY,
        out_r_TDATA,
        out_r_TVALID,
        out_r_TREADY,
        out_r_TKEEP,
        out_r_TSTRB,
        out_r_TLAST
);

parameter    ap_ST_fsm_state1 = 1'd1;

// synthesis translate_off
output kernel_block;
// synthesis translate_on
input   ap_clk;
input   ap_rst_n;
input  [127:0] i_in_V_TDATA;
input   i_in_V_TVALID;
output   i_in_V_TREADY;
input  [127:0] q_in_V_TDATA;
input   q_in_V_TVALID;
output   q_in_V_TREADY;
output  [255:0] out_r_TDATA;
output   out_r_TVALID;
input   out_r_TREADY;
output  [31:0] out_r_TKEEP;
output  [31:0] out_r_TSTRB;
output  [0:0] out_r_TLAST;

reg i_in_V_TREADY;
reg q_in_V_TREADY;
reg out_r_TVALID;

 reg    ap_rst_n_inv;
reg   [7:0] group_r;
reg    i_in_V_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    q_in_V_TDATA_blk_n;
reg    out_r_TDATA_blk_n;
wire   [7:0] add_ln870_fu_304_p2;
reg    ap_block_state1;
wire   [15:0] p_Result_13_fu_246_p4;
wire   [15:0] p_Result_12_fu_236_p4;
wire   [15:0] p_Result_11_fu_226_p4;
wire   [15:0] p_Result_10_fu_216_p4;
wire   [15:0] p_Result_2_fu_206_p4;
wire   [15:0] p_Result_9_fu_196_p4;
wire   [15:0] p_Result_7_fu_186_p4;
wire   [15:0] p_Result_5_fu_176_p4;
wire   [15:0] p_Result_3_fu_166_p4;
wire   [15:0] p_Result_1_fu_156_p4;
wire   [15:0] p_Result_s_fu_146_p4;
wire   [15:0] p_Result_8_fu_136_p4;
wire   [15:0] p_Result_6_fu_126_p4;
wire   [15:0] p_Result_4_fu_116_p4;
wire   [15:0] trunc_ln674_1_fu_112_p1;
wire   [15:0] trunc_ln674_fu_108_p1;
reg   [0:0] ap_NS_fsm;
reg    ap_ST_fsm_state1_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 group_r = 8'd0;
#0 ap_CS_fsm = 1'd1;
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if ((~((i_in_V_TVALID == 1'b0) | (out_r_TREADY == 1'b0) | (q_in_V_TVALID == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        group_r <= add_ln870_fu_304_p2;
    end
end

always @ (*) begin
    if (((i_in_V_TVALID == 1'b0) | (out_r_TREADY == 1'b0) | (q_in_V_TVALID == 1'b0))) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        i_in_V_TDATA_blk_n = i_in_V_TVALID;
    end else begin
        i_in_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((i_in_V_TVALID == 1'b0) | (out_r_TREADY == 1'b0) | (q_in_V_TVALID == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        i_in_V_TREADY = 1'b1;
    end else begin
        i_in_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        out_r_TDATA_blk_n = out_r_TREADY;
    end else begin
        out_r_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((i_in_V_TVALID == 1'b0) | (out_r_TREADY == 1'b0) | (q_in_V_TVALID == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        out_r_TVALID = 1'b1;
    end else begin
        out_r_TVALID = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state1)) begin
        q_in_V_TDATA_blk_n = q_in_V_TVALID;
    end else begin
        q_in_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((i_in_V_TVALID == 1'b0) | (out_r_TREADY == 1'b0) | (q_in_V_TVALID == 1'b0)) & (1'b1 == ap_CS_fsm_state1))) begin
        q_in_V_TREADY = 1'b1;
    end else begin
        q_in_V_TREADY = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            ap_NS_fsm = ap_ST_fsm_state1;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln870_fu_304_p2 = (group_r + 8'd1);

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

always @ (*) begin
    ap_block_state1 = ((i_in_V_TVALID == 1'b0) | (out_r_TREADY == 1'b0) | (q_in_V_TVALID == 1'b0));
end

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign out_r_TDATA = {{{{{{{{{{{{{{{{p_Result_13_fu_246_p4}, {p_Result_12_fu_236_p4}}, {p_Result_11_fu_226_p4}}, {p_Result_10_fu_216_p4}}, {p_Result_2_fu_206_p4}}, {p_Result_9_fu_196_p4}}, {p_Result_7_fu_186_p4}}, {p_Result_5_fu_176_p4}}, {p_Result_3_fu_166_p4}}, {p_Result_1_fu_156_p4}}, {p_Result_s_fu_146_p4}}, {p_Result_8_fu_136_p4}}, {p_Result_6_fu_126_p4}}, {p_Result_4_fu_116_p4}}, {trunc_ln674_1_fu_112_p1}}, {trunc_ln674_fu_108_p1}};

assign out_r_TKEEP = 32'd4294967295;

assign out_r_TLAST = ((group_r == 8'd255) ? 1'b1 : 1'b0);

assign out_r_TSTRB = 32'd0;

assign p_Result_10_fu_216_p4 = {{i_in_V_TDATA[111:96]}};

assign p_Result_11_fu_226_p4 = {{q_in_V_TDATA[111:96]}};

assign p_Result_12_fu_236_p4 = {{i_in_V_TDATA[127:112]}};

assign p_Result_13_fu_246_p4 = {{q_in_V_TDATA[127:112]}};

assign p_Result_1_fu_156_p4 = {{i_in_V_TDATA[63:48]}};

assign p_Result_2_fu_206_p4 = {{q_in_V_TDATA[95:80]}};

assign p_Result_3_fu_166_p4 = {{q_in_V_TDATA[63:48]}};

assign p_Result_4_fu_116_p4 = {{i_in_V_TDATA[31:16]}};

assign p_Result_5_fu_176_p4 = {{i_in_V_TDATA[79:64]}};

assign p_Result_6_fu_126_p4 = {{q_in_V_TDATA[31:16]}};

assign p_Result_7_fu_186_p4 = {{q_in_V_TDATA[79:64]}};

assign p_Result_8_fu_136_p4 = {{i_in_V_TDATA[47:32]}};

assign p_Result_9_fu_196_p4 = {{i_in_V_TDATA[95:80]}};

assign p_Result_s_fu_146_p4 = {{q_in_V_TDATA[47:32]}};

assign trunc_ln674_1_fu_112_p1 = q_in_V_TDATA[15:0];

assign trunc_ln674_fu_108_p1 = i_in_V_TDATA[15:0];


// synthesis translate_off
`include "pair_iq_hls_deadlock_kernel_monitor_top.vh"
// synthesis translate_on

endmodule //pair_iq
