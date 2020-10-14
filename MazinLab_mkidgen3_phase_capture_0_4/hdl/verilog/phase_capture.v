// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2.1
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="phase_capture,hls_ip_2019_2_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xczu28dr-ffvg1517-2-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=1.672000,HLS_SYN_LAT=3,HLS_SYN_TPT=1,HLS_SYN_MEM=2,HLS_SYN_DSP=0,HLS_SYN_FF=807,HLS_SYN_LUT=2100,HLS_VERSION=2019_2_1}" *)

module phase_capture (
        ap_clk,
        ap_rst_n,
        phasestream_TDATA,
        phasestream_TVALID,
        phasestream_TREADY,
        phasestream_TUSER,
        phasestream_TLAST,
        streamid_V,
        phaseout_TDATA,
        phaseout_TVALID,
        phaseout_TREADY,
        phaseout_TID,
        phaseout_TLAST,
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

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;
parameter    C_S_AXI_CONTROL_DATA_WIDTH = 32;
parameter    C_S_AXI_CONTROL_ADDR_WIDTH = 7;
parameter    C_S_AXI_DATA_WIDTH = 32;

parameter C_S_AXI_CONTROL_WSTRB_WIDTH = (32 / 8);
parameter C_S_AXI_WSTRB_WIDTH = (32 / 8);

input   ap_clk;
input   ap_rst_n;
input  [63:0] phasestream_TDATA;
input   phasestream_TVALID;
output   phasestream_TREADY;
input  [8:0] phasestream_TUSER;
input   phasestream_TLAST;
input  [2:0] streamid_V;
output  [63:0] phaseout_TDATA;
output   phaseout_TVALID;
input   phaseout_TREADY;
output  [2:0] phaseout_TID;
output   phaseout_TLAST;
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

reg phasestream_TREADY;

 reg    ap_rst_n_inv;
wire   [255:0] keep_V;
wire   [31:0] capturesize_V;
wire    configure;
reg   [31:0] p_remaining_V;
reg   [0:0] p_aligned;
reg    phasestream_TDATA_blk_n;
(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_block_pp0_stage0;
reg    phaseout_TDATA_blk_n;
reg    ap_enable_reg_pp0_iter2;
reg   [0:0] configure_read_reg_215;
reg   [0:0] configure_read_reg_215_pp0_iter1_reg;
reg   [0:0] and_ln54_reg_254;
reg   [0:0] p_Result_s_reg_258;
reg    ap_enable_reg_pp0_iter3;
reg   [0:0] configure_read_reg_215_pp0_iter2_reg;
reg   [0:0] and_ln54_reg_254_pp0_iter2_reg;
reg   [0:0] p_Result_s_reg_258_pp0_iter2_reg;
wire   [0:0] configure_read_read_fu_74_p2;
reg    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
reg    ap_predicate_op31_write_state3;
reg    ap_block_state3_io;
wire    regslice_both_phaseout_data_V_U_apdone_blk;
reg    ap_block_state4_pp0_stage0_iter3;
reg    ap_predicate_op51_write_state4;
reg    ap_block_state4_io;
reg    ap_block_pp0_stage0_11001;
reg   [31:0] capturesize_V_read_reg_224;
reg   [255:0] keep_V_read_reg_229;
reg   [63:0] phasestream_data_V_t_reg_234;
reg   [63:0] phasestream_data_V_t_reg_234_pp0_iter1_reg;
reg   [8:0] phasein_user_V_reg_239;
wire   [0:0] icmp_ln879_fu_129_p2;
reg   [0:0] icmp_ln879_reg_244;
wire   [0:0] phasetmp_last_fu_139_p2;
reg   [0:0] phasetmp_last_reg_249;
wire   [0:0] and_ln54_fu_166_p2;
wire   [0:0] p_Result_s_fu_186_p2;
reg    ap_enable_reg_pp0_iter1;
reg    ap_block_pp0_stage0_subdone;
wire   [31:0] add_ln701_fu_192_p2;
wire   [0:0] or_ln47_fu_149_p2;
reg    ap_block_pp0_stage0_01001;
wire   [0:0] icmp_ln895_fu_160_p2;
wire   [255:0] zext_ln791_fu_172_p1;
wire   [255:0] shl_ln791_fu_175_p2;
wire   [255:0] and_ln791_fu_181_p2;
reg   [0:0] ap_NS_fsm;
wire    ap_reset_idle_pp0;
reg    ap_idle_pp0;
wire    ap_enable_pp0;
wire    regslice_both_phasestream_data_V_U_apdone_blk;
wire   [63:0] phasestream_TDATA_int;
wire    phasestream_TVALID_int;
reg    phasestream_TREADY_int;
wire    regslice_both_phasestream_data_V_U_ack_in;
wire    regslice_both_phasestream_user_V_U_apdone_blk;
wire   [8:0] phasestream_TUSER_int;
wire    regslice_both_phasestream_user_V_U_vld_out;
wire    regslice_both_phasestream_user_V_U_ack_in;
wire    regslice_both_w1_phasestream_last_U_apdone_blk;
wire    phasestream_TLAST_int;
wire    regslice_both_w1_phasestream_last_U_vld_out;
wire    regslice_both_w1_phasestream_last_U_ack_in;
reg    phaseout_TVALID_int;
wire    phaseout_TREADY_int;
wire    regslice_both_phaseout_data_V_U_vld_out;
wire    regslice_both_phaseout_id_V_U_apdone_blk;
wire    regslice_both_phaseout_id_V_U_ack_in_dummy;
wire    regslice_both_phaseout_id_V_U_vld_out;
wire    regslice_both_w1_phaseout_last_U_apdone_blk;
wire    phaseout_TLAST_int;
wire    regslice_both_w1_phaseout_last_U_ack_in_dummy;
wire    regslice_both_w1_phaseout_last_U_vld_out;
reg    ap_condition_176;
reg    ap_condition_178;

// power-on initialization
initial begin
#0 p_remaining_V = 32'd0;
#0 p_aligned = 1'd0;
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
end

phase_capture_control_s_axi #(
    .C_S_AXI_ADDR_WIDTH( C_S_AXI_CONTROL_ADDR_WIDTH ),
    .C_S_AXI_DATA_WIDTH( C_S_AXI_CONTROL_DATA_WIDTH ))
phase_capture_control_s_axi_U(
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
    .keep_V(keep_V),
    .capturesize_V(capturesize_V),
    .configure(configure)
);

regslice_both #(
    .DataWidth( 64 ))
regslice_both_phasestream_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(phasestream_TDATA),
    .vld_in(phasestream_TVALID),
    .ack_in(regslice_both_phasestream_data_V_U_ack_in),
    .data_out(phasestream_TDATA_int),
    .vld_out(phasestream_TVALID_int),
    .ack_out(phasestream_TREADY_int),
    .apdone_blk(regslice_both_phasestream_data_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 9 ))
regslice_both_phasestream_user_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(phasestream_TUSER),
    .vld_in(phasestream_TVALID),
    .ack_in(regslice_both_phasestream_user_V_U_ack_in),
    .data_out(phasestream_TUSER_int),
    .vld_out(regslice_both_phasestream_user_V_U_vld_out),
    .ack_out(phasestream_TREADY_int),
    .apdone_blk(regslice_both_phasestream_user_V_U_apdone_blk)
);

regslice_both_w1 #(
    .DataWidth( 1 ))
regslice_both_w1_phasestream_last_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(phasestream_TLAST),
    .vld_in(phasestream_TVALID),
    .ack_in(regslice_both_w1_phasestream_last_U_ack_in),
    .data_out(phasestream_TLAST_int),
    .vld_out(regslice_both_w1_phasestream_last_U_vld_out),
    .ack_out(phasestream_TREADY_int),
    .apdone_blk(regslice_both_w1_phasestream_last_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 64 ))
regslice_both_phaseout_data_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(phasestream_data_V_t_reg_234_pp0_iter1_reg),
    .vld_in(phaseout_TVALID_int),
    .ack_in(phaseout_TREADY_int),
    .data_out(phaseout_TDATA),
    .vld_out(regslice_both_phaseout_data_V_U_vld_out),
    .ack_out(phaseout_TREADY),
    .apdone_blk(regslice_both_phaseout_data_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 3 ))
regslice_both_phaseout_id_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(streamid_V),
    .vld_in(phaseout_TVALID_int),
    .ack_in(regslice_both_phaseout_id_V_U_ack_in_dummy),
    .data_out(phaseout_TID),
    .vld_out(regslice_both_phaseout_id_V_U_vld_out),
    .ack_out(phaseout_TREADY),
    .apdone_blk(regslice_both_phaseout_id_V_U_apdone_blk)
);

regslice_both_w1 #(
    .DataWidth( 1 ))
regslice_both_w1_phaseout_last_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst_n_inv),
    .data_in(phaseout_TLAST_int),
    .vld_in(phaseout_TVALID_int),
    .ack_in(regslice_both_w1_phaseout_last_U_ack_in_dummy),
    .data_out(phaseout_TLAST),
    .vld_out(regslice_both_w1_phaseout_last_U_vld_out),
    .ack_out(phaseout_TREADY),
    .apdone_blk(regslice_both_w1_phaseout_last_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter1 <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst_n_inv == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_176)) begin
        if ((configure_read_reg_215 == 1'd1)) begin
            p_aligned <= 1'd0;
        end else if ((configure_read_reg_215 == 1'd0)) begin
            p_aligned <= or_ln47_fu_149_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b1 == ap_condition_176)) begin
        if ((configure_read_reg_215 == 1'd1)) begin
            p_remaining_V <= capturesize_V_read_reg_224;
        end else if ((1'b1 == ap_condition_178)) begin
            p_remaining_V <= add_ln701_fu_192_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((configure_read_reg_215 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        and_ln54_reg_254 <= and_ln54_fu_166_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        and_ln54_reg_254_pp0_iter2_reg <= and_ln54_reg_254;
        configure_read_reg_215_pp0_iter2_reg <= configure_read_reg_215_pp0_iter1_reg;
        p_Result_s_reg_258_pp0_iter2_reg <= p_Result_s_reg_258;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        capturesize_V_read_reg_224 <= capturesize_V;
        configure_read_reg_215 <= configure;
        configure_read_reg_215_pp0_iter1_reg <= configure_read_reg_215;
        keep_V_read_reg_229 <= keep_V;
        phasein_user_V_reg_239 <= phasestream_TUSER_int;
        phasestream_data_V_t_reg_234 <= phasestream_TDATA_int;
        phasestream_data_V_t_reg_234_pp0_iter1_reg <= phasestream_data_V_t_reg_234;
        phasetmp_last_reg_249 <= phasetmp_last_fu_139_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((configure_read_read_fu_74_p2 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        icmp_ln879_reg_244 <= icmp_ln879_fu_129_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'd1 == and_ln54_fu_166_p2) & (configure_read_reg_215 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        p_Result_s_reg_258 <= p_Result_s_fu_186_p2;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (1'b1 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

assign ap_reset_idle_pp0 = 1'b0;

always @ (*) begin
    if ((((1'd1 == and_ln54_reg_254_pp0_iter2_reg) & (1'b0 == ap_block_pp0_stage0) & (p_Result_s_reg_258_pp0_iter2_reg == 1'd0) & (configure_read_reg_215_pp0_iter2_reg == 1'd0) & (ap_enable_reg_pp0_iter3 == 1'b1)) | ((1'd1 == and_ln54_reg_254) & (1'b0 == ap_block_pp0_stage0) & (p_Result_s_reg_258 == 1'd0) & (configure_read_reg_215_pp0_iter1_reg == 1'd0) & (ap_enable_reg_pp0_iter2 == 1'b1)))) begin
        phaseout_TDATA_blk_n = phaseout_TREADY_int;
    end else begin
        phaseout_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((ap_predicate_op31_write_state3 == 1'b1) & (ap_enable_reg_pp0_iter2 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        phaseout_TVALID_int = 1'b1;
    end else begin
        phaseout_TVALID_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        phasestream_TDATA_blk_n = phasestream_TVALID_int;
    end else begin
        phasestream_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((phasestream_TVALID == 1'b1) & (regslice_both_phasestream_data_V_U_ack_in == 1'b1))) begin
        phasestream_TREADY = 1'b1;
    end else begin
        phasestream_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (1'b0 == ap_block_pp0_stage0_11001))) begin
        phasestream_TREADY_int = 1'b1;
    end else begin
        phasestream_TREADY_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln701_fu_192_p2 = ($signed(p_remaining_V) + $signed(32'd4294967295));

assign and_ln54_fu_166_p2 = (or_ln47_fu_149_p2 & icmp_ln895_fu_160_p2);

assign and_ln791_fu_181_p2 = (shl_ln791_fu_175_p2 & keep_V_read_reg_229);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = (((ap_enable_reg_pp0_iter3 == 1'b1) & (regslice_both_phaseout_data_V_U_apdone_blk == 1'b1)) | ((phasestream_TVALID_int == 1'b0) & (1'b1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = (((ap_enable_reg_pp0_iter3 == 1'b1) & ((1'b1 == ap_block_state4_io) | (regslice_both_phaseout_data_V_U_apdone_blk == 1'b1))) | ((1'b1 == ap_block_state3_io) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((phasestream_TVALID_int == 1'b0) & (1'b1 == 1'b1)));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = (((ap_enable_reg_pp0_iter3 == 1'b1) & ((1'b1 == ap_block_state4_io) | (regslice_both_phaseout_data_V_U_apdone_blk == 1'b1))) | ((1'b1 == ap_block_state3_io) & (ap_enable_reg_pp0_iter2 == 1'b1)) | ((phasestream_TVALID_int == 1'b0) & (1'b1 == 1'b1)));
end

always @ (*) begin
    ap_block_state1_pp0_stage0_iter0 = (phasestream_TVALID_int == 1'b0);
end

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state3_io = ((phaseout_TREADY_int == 1'b0) & (ap_predicate_op31_write_state3 == 1'b1));
end

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state4_io = ((phaseout_TREADY_int == 1'b0) & (ap_predicate_op51_write_state4 == 1'b1));
end

always @ (*) begin
    ap_block_state4_pp0_stage0_iter3 = (regslice_both_phaseout_data_V_U_apdone_blk == 1'b1);
end

always @ (*) begin
    ap_condition_176 = ((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b0 == ap_block_pp0_stage0_11001));
end

always @ (*) begin
    ap_condition_178 = ((1'd1 == and_ln54_fu_166_p2) & (configure_read_reg_215 == 1'd0) & (p_Result_s_fu_186_p2 == 1'd0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

always @ (*) begin
    ap_predicate_op31_write_state3 = ((1'd1 == and_ln54_reg_254) & (p_Result_s_reg_258 == 1'd0) & (configure_read_reg_215_pp0_iter1_reg == 1'd0));
end

always @ (*) begin
    ap_predicate_op51_write_state4 = ((1'd1 == and_ln54_reg_254_pp0_iter2_reg) & (p_Result_s_reg_258_pp0_iter2_reg == 1'd0) & (configure_read_reg_215_pp0_iter2_reg == 1'd0));
end

always @ (*) begin
    ap_rst_n_inv = ~ap_rst_n;
end

assign configure_read_read_fu_74_p2 = configure;

assign icmp_ln879_fu_129_p2 = ((phasestream_TUSER_int == 9'd0) ? 1'b1 : 1'b0);

assign icmp_ln895_fu_160_p2 = ((p_remaining_V != 32'd0) ? 1'b1 : 1'b0);

assign or_ln47_fu_149_p2 = (p_aligned | icmp_ln879_reg_244);

assign p_Result_s_fu_186_p2 = ((and_ln791_fu_181_p2 == 256'd0) ? 1'b1 : 1'b0);

assign phaseout_TLAST_int = phasetmp_last_reg_249;

assign phaseout_TVALID = regslice_both_phaseout_data_V_U_vld_out;

assign phasetmp_last_fu_139_p2 = ((p_remaining_V == 32'd1) ? 1'b1 : 1'b0);

assign shl_ln791_fu_175_p2 = 256'd1 << zext_ln791_fu_172_p1;

assign zext_ln791_fu_172_p1 = phasein_user_V_reg_239;

endmodule //phase_capture