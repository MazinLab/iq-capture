// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1ns/1ps
module iq_capture_control_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 10,
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
    input  wire                          clk,
    input  wire                          rst,
    input  wire [7:0]                    keep_V_address0,
    input  wire                          keep_V_ce0,
    output wire [7:0]                    keep_V_q0,
    output wire [31:0]                   capturesize_V,
    output wire [1:0]                    streamselect_V
);
//------------------------Address Info-------------------
// 0x000 : reserved
// 0x004 : reserved
// 0x008 : reserved
// 0x00c : reserved
// 0x200 : Data signal of capturesize_V
//         bit 31~0 - capturesize_V[31:0] (Read/Write)
// 0x204 : reserved
// 0x208 : Data signal of streamselect_V
//         bit 1~0 - streamselect_V[1:0] (Read/Write)
//         others  - reserved
// 0x20c : reserved
// 0x100 ~
// 0x1ff : Memory 'keep_V' (256 * 8b)
//         Word n : bit [ 7: 0] - keep_V[4n]
//                  bit [15: 8] - keep_V[4n+1]
//                  bit [23:16] - keep_V[4n+2]
//                  bit [31:24] - keep_V[4n+3]
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_CAPTURESIZE_V_DATA_0  = 10'h200,
    ADDR_CAPTURESIZE_V_CTRL    = 10'h204,
    ADDR_STREAMSELECT_V_DATA_0 = 10'h208,
    ADDR_STREAMSELECT_V_CTRL   = 10'h20c,
    ADDR_KEEP_V_BASE           = 10'h100,
    ADDR_KEEP_V_HIGH           = 10'h1ff,
    WRIDLE                     = 2'd0,
    WRDATA                     = 2'd1,
    WRRESP                     = 2'd2,
    WRRESET                    = 2'd3,
    RDIDLE                     = 2'd0,
    RDDATA                     = 2'd1,
    RDRESET                    = 2'd2,
    ADDR_BITS         = 10;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [31:0]                   wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [31:0]                   rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg  [31:0]                   int_capturesize_V = 'b0;
    reg  [1:0]                    int_streamselect_V = 'b0;
    // memory signals
    wire [5:0]                    int_keep_V_address0;
    wire                          int_keep_V_ce0;
    wire                          int_keep_V_we0;
    wire [3:0]                    int_keep_V_be0;
    wire [31:0]                   int_keep_V_d0;
    wire [31:0]                   int_keep_V_q0;
    wire [5:0]                    int_keep_V_address1;
    wire                          int_keep_V_ce1;
    wire                          int_keep_V_we1;
    wire [3:0]                    int_keep_V_be1;
    wire [31:0]                   int_keep_V_d1;
    wire [31:0]                   int_keep_V_q1;
    reg                           int_keep_V_read;
    reg                           int_keep_V_write;
    reg  [1:0]                    int_keep_V_shift;

//------------------------Instantiation------------------
// int_keep_V
iq_capture_control_s_axi_ram #(
    .BYTES    ( 4 ),
    .DEPTH    ( 64 )
) int_keep_V (
    .clk0     ( clk ),
    .address0 ( int_keep_V_address0 ),
    .ce0      ( int_keep_V_ce0 ),
    .we0      ( int_keep_V_we0 ),
    .be0      ( int_keep_V_be0 ),
    .d0       ( int_keep_V_d0 ),
    .q0       ( int_keep_V_q0 ),
    .clk1     ( ACLK ),
    .address1 ( int_keep_V_address1 ),
    .ce1      ( int_keep_V_ce1 ),
    .we1      ( int_keep_V_we1 ),
    .be1      ( int_keep_V_be1 ),
    .d1       ( int_keep_V_d1 ),
    .q1       ( int_keep_V_q1 )
);

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
assign RVALID  = (rstate == RDDATA) & !int_keep_V_read;
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
            rdata <= 1'b0;
            case (raddr)
                ADDR_CAPTURESIZE_V_DATA_0: begin
                    rdata <= int_capturesize_V[31:0];
                end
                ADDR_STREAMSELECT_V_DATA_0: begin
                    rdata <= int_streamselect_V[1:0];
                end
            endcase
        end
        else if (int_keep_V_read) begin
            rdata <= int_keep_V_q1;
        end
    end
end


//------------------------Register logic-----------------
assign capturesize_V  = int_capturesize_V;
assign streamselect_V = int_streamselect_V;
// int_capturesize_V[31:0]
always @(posedge clk) begin
    if (rst)
        int_capturesize_V[31:0] <= 0;
    else if (w_hs && waddr == ADDR_CAPTURESIZE_V_DATA_0)
        int_capturesize_V[31:0] <= (WDATA[31:0] & wmask) | (int_capturesize_V[31:0] & ~wmask);
end
// int_streamselect_V[1:0]
always @(posedge clk) begin
    if (rst)
        int_streamselect_V[1:0] <= 0;
    else if (w_hs && waddr == ADDR_STREAMSELECT_V_DATA_0)
        int_streamselect_V[1:0] <= (WDATA[31:0] & wmask) | (int_streamselect_V[1:0] & ~wmask);
end

//------------------------Memory logic-------------------
// keep_V
assign int_keep_V_address0 = keep_V_address0 >> 2;
assign int_keep_V_ce0      = keep_V_ce0;
assign int_keep_V_we0      = 1'b0;
assign int_keep_V_be0      = 1'b0;
assign int_keep_V_d0       = 1'b0;
assign keep_V_q0           = int_keep_V_q0 >> (int_keep_V_shift * 8);
assign int_keep_V_address1 = ar_hs? raddr[7:2] : waddr[7:2];
assign int_keep_V_ce1      = ar_hs | (int_keep_V_write & WVALID);
assign int_keep_V_we1      = int_keep_V_write & WVALID;
assign int_keep_V_be1      = WSTRB;
assign int_keep_V_d1       = WDATA;
// int_keep_V_read
always @(posedge ACLK) begin
    if (ARESET)
        int_keep_V_read <= 1'b0;
    else if (ACLK_EN) begin
        if (ar_hs && raddr >= ADDR_KEEP_V_BASE && raddr <= ADDR_KEEP_V_HIGH)
            int_keep_V_read <= 1'b1;
        else
            int_keep_V_read <= 1'b0;
    end
end

// int_keep_V_write
always @(posedge ACLK) begin
    if (ARESET)
        int_keep_V_write <= 1'b0;
    else if (ACLK_EN) begin
        if (aw_hs && AWADDR[ADDR_BITS-1:0] >= ADDR_KEEP_V_BASE && AWADDR[ADDR_BITS-1:0] <= ADDR_KEEP_V_HIGH)
            int_keep_V_write <= 1'b1;
        else if (WVALID)
            int_keep_V_write <= 1'b0;
    end
end

// int_keep_V_shift
always @(posedge clk) begin
    if (ACLK_EN) begin
        if (keep_V_ce0)
            int_keep_V_shift <= keep_V_address0[1:0];
    end
end


endmodule


`timescale 1ns/1ps

module iq_capture_control_s_axi_ram
#(parameter
    BYTES  = 4,
    DEPTH  = 256,
    AWIDTH = log2(DEPTH)
) (
    input  wire               clk0,
    input  wire [AWIDTH-1:0]  address0,
    input  wire               ce0,
    input  wire               we0,
    input  wire [BYTES-1:0]   be0,
    input  wire [BYTES*8-1:0] d0,
    output reg  [BYTES*8-1:0] q0,
    input  wire               clk1,
    input  wire [AWIDTH-1:0]  address1,
    input  wire               ce1,
    input  wire               we1,
    input  wire [BYTES-1:0]   be1,
    input  wire [BYTES*8-1:0] d1,
    output reg  [BYTES*8-1:0] q1
);
//------------------------Local signal-------------------
reg  [BYTES*8-1:0] mem[0:DEPTH-1];
//------------------------Task and function--------------
function integer log2;
    input integer x;
    integer n, m;
begin
    n = 1;
    m = 2;
    while (m < x) begin
        n = n + 1;
        m = m * 2;
    end
    log2 = n;
end
endfunction
//------------------------Body---------------------------
// read port 0
always @(posedge clk0) begin
    if (ce0) q0 <= mem[address0];
end

// read port 1
always @(posedge clk1) begin
    if (ce1) q1 <= mem[address1];
end

genvar i;
generate
    for (i = 0; i < BYTES; i = i + 1) begin : gen_write
        // write port 0
        always @(posedge clk0) begin
            if (ce0 & we0 & be0[i]) begin
                mem[address0][8*i+7:8*i] <= d0[8*i+7:8*i];
            end
        end
        // write port 1
        always @(posedge clk1) begin
            if (ce1 & we1 & be1[i]) begin
                mem[address1][8*i+7:8*i] <= d1[8*i+7:8*i];
            end
        end
    end
endgenerate

endmodule

