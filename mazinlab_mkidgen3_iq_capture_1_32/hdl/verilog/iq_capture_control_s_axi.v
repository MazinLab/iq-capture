// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1ns/1ps
module iq_capture_control_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 7,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire                          interrupt,
    input  wire                          clk,
    input  wire                          rst,
    output wire [255:0]                  keep,
    output wire [34:0]                   total_capturesize,
    output wire [26:0]                   capturesize,
    output wire [63:0]                   iqout,
    output wire                          ap_start,
    input  wire                          ap_done,
    input  wire                          ap_ready,
    input  wire                          ap_idle
);
//------------------------Address Info-------------------
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0  - enable ap_done interrupt (Read/Write)
//        bit 1  - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/TOW)
//        bit 0  - ap_done (COR/TOW)
//        bit 1  - ap_ready (COR/TOW)
//        others - reserved
// 0x10 : Data signal of keep
//        bit 31~0 - keep[31:0] (Read/Write)
// 0x14 : Data signal of keep
//        bit 31~0 - keep[63:32] (Read/Write)
// 0x18 : Data signal of keep
//        bit 31~0 - keep[95:64] (Read/Write)
// 0x1c : Data signal of keep
//        bit 31~0 - keep[127:96] (Read/Write)
// 0x20 : Data signal of keep
//        bit 31~0 - keep[159:128] (Read/Write)
// 0x24 : Data signal of keep
//        bit 31~0 - keep[191:160] (Read/Write)
// 0x28 : Data signal of keep
//        bit 31~0 - keep[223:192] (Read/Write)
// 0x2c : Data signal of keep
//        bit 31~0 - keep[255:224] (Read/Write)
// 0x30 : reserved
// 0x34 : Data signal of total_capturesize
//        bit 31~0 - total_capturesize[31:0] (Read/Write)
// 0x38 : Data signal of total_capturesize
//        bit 2~0 - total_capturesize[34:32] (Read/Write)
//        others  - reserved
// 0x3c : reserved
// 0x40 : Data signal of capturesize
//        bit 26~0 - capturesize[26:0] (Read/Write)
//        others   - reserved
// 0x44 : reserved
// 0x48 : Data signal of iqout
//        bit 31~0 - iqout[31:0] (Read/Write)
// 0x4c : Data signal of iqout
//        bit 31~0 - iqout[63:32] (Read/Write)
// 0x50 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_AP_CTRL                  = 7'h00,
    ADDR_GIE                      = 7'h04,
    ADDR_IER                      = 7'h08,
    ADDR_ISR                      = 7'h0c,
    ADDR_KEEP_DATA_0              = 7'h10,
    ADDR_KEEP_DATA_1              = 7'h14,
    ADDR_KEEP_DATA_2              = 7'h18,
    ADDR_KEEP_DATA_3              = 7'h1c,
    ADDR_KEEP_DATA_4              = 7'h20,
    ADDR_KEEP_DATA_5              = 7'h24,
    ADDR_KEEP_DATA_6              = 7'h28,
    ADDR_KEEP_DATA_7              = 7'h2c,
    ADDR_KEEP_CTRL                = 7'h30,
    ADDR_TOTAL_CAPTURESIZE_DATA_0 = 7'h34,
    ADDR_TOTAL_CAPTURESIZE_DATA_1 = 7'h38,
    ADDR_TOTAL_CAPTURESIZE_CTRL   = 7'h3c,
    ADDR_CAPTURESIZE_DATA_0       = 7'h40,
    ADDR_CAPTURESIZE_CTRL         = 7'h44,
    ADDR_IQOUT_DATA_0             = 7'h48,
    ADDR_IQOUT_DATA_1             = 7'h4c,
    ADDR_IQOUT_CTRL               = 7'h50,
    WRIDLE                        = 2'd0,
    WRDATA                        = 2'd1,
    WRRESP                        = 2'd2,
    WRRESET                       = 2'd3,
    RDIDLE                        = 2'd0,
    RDDATA                        = 2'd1,
    RDRESET                       = 2'd2,
    ADDR_BITS                = 7;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [C_S_AXI_DATA_WIDTH-1:0] wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [C_S_AXI_DATA_WIDTH-1:0] rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg                           int_ap_idle;
    reg                           int_ap_ready = 1'b0;
    reg                           int_ap_done = 1'b0;
    wire                          ap_done_get;
    reg                           ap_done_ext;
    reg                           int_ap_start = 1'b0;
    wire                          ap_start_set;
    reg                           ap_start_mask;
    reg                           int_auto_restart = 1'b0;
    wire                          auto_restart_set;
    reg                           int_gie = 1'b0;
    reg  [1:0]                    int_ier = 2'b0;
    wire                          ier_toggle;
    reg                           ier_mask;
    reg  [1:0]                    int_isr = 2'b0;
    wire                          isr_toggle;
    reg                           isr_mask;
    reg  [255:0]                  int_keep = 'b0;
    reg  [34:0]                   int_total_capturesize = 'b0;
    reg  [26:0]                   int_capturesize = 'b0;
    reg  [63:0]                   int_iqout = 'b0;

//------------------------Instantiation------------------


//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 'b0;
            case (raddr)
                ADDR_AP_CTRL: begin
                    rdata[0] <= int_ap_start;
                    rdata[1] <= int_ap_done;
                    rdata[2] <= int_ap_idle;
                    rdata[3] <= int_ap_ready;
                    rdata[7] <= int_auto_restart;
                end
                ADDR_GIE: begin
                    rdata <= int_gie;
                end
                ADDR_IER: begin
                    rdata <= int_ier;
                end
                ADDR_ISR: begin
                    rdata <= int_isr;
                end
                ADDR_KEEP_DATA_0: begin
                    rdata <= int_keep[31:0];
                end
                ADDR_KEEP_DATA_1: begin
                    rdata <= int_keep[63:32];
                end
                ADDR_KEEP_DATA_2: begin
                    rdata <= int_keep[95:64];
                end
                ADDR_KEEP_DATA_3: begin
                    rdata <= int_keep[127:96];
                end
                ADDR_KEEP_DATA_4: begin
                    rdata <= int_keep[159:128];
                end
                ADDR_KEEP_DATA_5: begin
                    rdata <= int_keep[191:160];
                end
                ADDR_KEEP_DATA_6: begin
                    rdata <= int_keep[223:192];
                end
                ADDR_KEEP_DATA_7: begin
                    rdata <= int_keep[255:224];
                end
                ADDR_TOTAL_CAPTURESIZE_DATA_0: begin
                    rdata <= int_total_capturesize[31:0];
                end
                ADDR_TOTAL_CAPTURESIZE_DATA_1: begin
                    rdata <= int_total_capturesize[34:32];
                end
                ADDR_CAPTURESIZE_DATA_0: begin
                    rdata <= int_capturesize[26:0];
                end
                ADDR_IQOUT_DATA_0: begin
                    rdata <= int_iqout[31:0];
                end
                ADDR_IQOUT_DATA_1: begin
                    rdata <= int_iqout[63:32];
                end
            endcase
        end
    end
end


//------------------------Register logic-----------------
assign interrupt         = int_gie & (|int_isr);
assign ap_start          = int_ap_start;
assign ap_start_set      = w_hs && waddr == ADDR_AP_CTRL && WSTRB[0] && WDATA[0];
assign ap_done_get       = ar_hs && raddr == ADDR_AP_CTRL && int_ap_done;
assign auto_restart_set  = w_hs && waddr == ADDR_AP_CTRL && WSTRB[0];
assign isr_toggle        = w_hs && waddr == ADDR_ISR && WSTRB[0];
assign keep              = int_keep;
assign total_capturesize = int_total_capturesize;
assign capturesize       = int_capturesize;
assign iqout             = int_iqout;
// ap_start_mask
always @(posedge clk) begin
    if (rst)
        ap_start_mask <= 1'b0;
    else
        ap_start_mask <= ap_start_set;
end
// int_ap_start
always @(posedge clk) begin
    if (rst)
        int_ap_start <= 1'b0;
    else if (ap_start_set == 1'b1 && ap_start_mask == 1'b0)
        int_ap_start <= 1'b1;
    else if (ap_ready)
        int_ap_start <= int_auto_restart; // clear on handshake/auto restart
end
// ap_done_ext
always @(posedge clk) begin
    if (rst)
        ap_done_ext <= 1'b0;
    else
        ap_done_ext <= ap_done_get;
end
// int_ap_done
always @(posedge clk) begin
    if (rst)
        int_ap_done <= 1'b0;
    else if (ap_done)
        int_ap_done <= 1'b1;
    else if (ap_done_get == 1'b0 && ap_done_ext == 1'b1)
        int_ap_done <= 1'b0; // clear on read
end
// int_ap_idle
always @(posedge clk) begin
    if (rst)
        int_ap_idle <= 1'b0;
    else
        int_ap_idle <= ap_idle;
end
// int_ap_ready
always @(posedge clk) begin
    if (rst)
        int_ap_ready <= 1'b0;
    else
        int_ap_ready <= ap_ready;
end
// int_auto_restart
always @(posedge clk) begin
    if (rst)
        int_auto_restart <= 1'b0;
    else if (auto_restart_set == 1'b1)
        int_auto_restart <=  WDATA[7];
end
// int_gie
always @(posedge clk) begin
    if (rst)
        int_gie <= 1'b0;
    else if (w_hs && waddr == ADDR_GIE && WSTRB[0])
        int_gie <= WDATA[0];
end
// int_ier
always @(posedge clk) begin
    if (rst)
        int_ier <= 1'b0;
    else if (w_hs && waddr == ADDR_IER && WSTRB[0])
        int_ier <= WDATA[1:0];
end
// isr_mask
always @(posedge clk) begin
    if (rst)
        isr_mask <= 1'b0;
    else
        isr_mask <= isr_toggle;
end
// int_isr[0]
always @(posedge clk) begin
    if (rst)
        int_isr[0] <= 1'b0;
    else if (int_ier[0] & ap_done)
        int_isr[0] <= 1'b1;
    else if (isr_toggle == 1'b1 && isr_mask == 1'b0)
        int_isr[0] <= int_isr[0] ^ WDATA[0]; // toggle on write
end
// int_isr[1]
always @(posedge clk) begin
    if (rst)
        int_isr[1] <= 1'b0;
    else if (int_ier[1] & ap_ready)
        int_isr[1] <= 1'b1;
    else if (isr_toggle == 1'b1 && isr_mask == 1'b0)
        int_isr[1] <= int_isr[1] ^ WDATA[1]; // toggle on write
end
// int_keep[31:0]
always @(posedge clk) begin
    if (rst)
        int_keep[31:0] <= 0;
    else if (w_hs && waddr == ADDR_KEEP_DATA_0)
        int_keep[31:0] <= (WDATA[31:0] & wmask) | (int_keep[31:0] & ~wmask);
end
// int_keep[63:32]
always @(posedge clk) begin
    if (rst)
        int_keep[63:32] <= 0;
    else if (w_hs && waddr == ADDR_KEEP_DATA_1)
        int_keep[63:32] <= (WDATA[31:0] & wmask) | (int_keep[63:32] & ~wmask);
end
// int_keep[95:64]
always @(posedge clk) begin
    if (rst)
        int_keep[95:64] <= 0;
    else if (w_hs && waddr == ADDR_KEEP_DATA_2)
        int_keep[95:64] <= (WDATA[31:0] & wmask) | (int_keep[95:64] & ~wmask);
end
// int_keep[127:96]
always @(posedge clk) begin
    if (rst)
        int_keep[127:96] <= 0;
    else if (w_hs && waddr == ADDR_KEEP_DATA_3)
        int_keep[127:96] <= (WDATA[31:0] & wmask) | (int_keep[127:96] & ~wmask);
end
// int_keep[159:128]
always @(posedge clk) begin
    if (rst)
        int_keep[159:128] <= 0;
    else if (w_hs && waddr == ADDR_KEEP_DATA_4)
        int_keep[159:128] <= (WDATA[31:0] & wmask) | (int_keep[159:128] & ~wmask);
end
// int_keep[191:160]
always @(posedge clk) begin
    if (rst)
        int_keep[191:160] <= 0;
    else if (w_hs && waddr == ADDR_KEEP_DATA_5)
        int_keep[191:160] <= (WDATA[31:0] & wmask) | (int_keep[191:160] & ~wmask);
end
// int_keep[223:192]
always @(posedge clk) begin
    if (rst)
        int_keep[223:192] <= 0;
    else if (w_hs && waddr == ADDR_KEEP_DATA_6)
        int_keep[223:192] <= (WDATA[31:0] & wmask) | (int_keep[223:192] & ~wmask);
end
// int_keep[255:224]
always @(posedge clk) begin
    if (rst)
        int_keep[255:224] <= 0;
    else if (w_hs && waddr == ADDR_KEEP_DATA_7)
        int_keep[255:224] <= (WDATA[31:0] & wmask) | (int_keep[255:224] & ~wmask);
end
// int_total_capturesize[31:0]
always @(posedge clk) begin
    if (rst)
        int_total_capturesize[31:0] <= 0;
    else if (w_hs && waddr == ADDR_TOTAL_CAPTURESIZE_DATA_0)
        int_total_capturesize[31:0] <= (WDATA[31:0] & wmask) | (int_total_capturesize[31:0] & ~wmask);
end
// int_total_capturesize[34:32]
always @(posedge clk) begin
    if (rst)
        int_total_capturesize[34:32] <= 0;
    else if (w_hs && waddr == ADDR_TOTAL_CAPTURESIZE_DATA_1)
        int_total_capturesize[34:32] <= (WDATA[31:0] & wmask) | (int_total_capturesize[34:32] & ~wmask);
end
// int_capturesize[26:0]
always @(posedge clk) begin
    if (rst)
        int_capturesize[26:0] <= 0;
    else if (w_hs && waddr == ADDR_CAPTURESIZE_DATA_0)
        int_capturesize[26:0] <= (WDATA[31:0] & wmask) | (int_capturesize[26:0] & ~wmask);
end
// int_iqout[31:0]
always @(posedge clk) begin
    if (rst)
        int_iqout[31:0] <= 0;
    else if (w_hs && waddr == ADDR_IQOUT_DATA_0)
        int_iqout[31:0] <= (WDATA[31:0] & wmask) | (int_iqout[31:0] & ~wmask);
end
// int_iqout[63:32]
always @(posedge clk) begin
    if (rst)
        int_iqout[63:32] <= 0;
    else if (w_hs && waddr == ADDR_IQOUT_DATA_1)
        int_iqout[63:32] <= (WDATA[31:0] & wmask) | (int_iqout[63:32] & ~wmask);
end

//------------------------Memory logic-------------------

endmodule
