
wire kernel_monitor_reset;
wire kernel_monitor_clock;
assign kernel_monitor_reset = ~ap_rst_n;
assign kernel_monitor_clock = ap_clk;
wire [0:0] axis_block_sigs;
wire [4:0] inst_idle_sigs;
wire [2:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~getinstream_U0.filtered_TDATA_blk_n;

assign inst_idle_sigs[0] = entry_proc_U0.ap_idle;
assign inst_block_sigs[0] = (entry_proc_U0.ap_done & ~entry_proc_U0.ap_continue);
assign inst_idle_sigs[1] = getinstream_U0.ap_idle;
assign inst_block_sigs[1] = (getinstream_U0.ap_done & ~getinstream_U0.ap_continue) | ~getinstream_U0.buf8_blk_n;
assign inst_idle_sigs[2] = s2mm_rewind_U0.ap_idle;
assign inst_block_sigs[2] = (s2mm_rewind_U0.ap_done & ~s2mm_rewind_U0.ap_continue) | ~s2mm_rewind_U0.buf8_blk_n;

assign inst_idle_sigs[3] = 1'b0;
assign inst_idle_sigs[4] = getinstream_U0.ap_idle;

write_axi256_hls_deadlock_idx0_monitor write_axi256_hls_deadlock_idx0_monitor_U (
    .clock(kernel_monitor_clock),
    .reset(kernel_monitor_reset),
    .axis_block_sigs(axis_block_sigs),
    .inst_idle_sigs(inst_idle_sigs),
    .inst_block_sigs(inst_block_sigs),
    .block(kernel_block)
);

