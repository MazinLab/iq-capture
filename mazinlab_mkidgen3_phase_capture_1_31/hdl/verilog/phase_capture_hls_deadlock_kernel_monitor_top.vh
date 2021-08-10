
wire kernel_monitor_reset;
wire kernel_monitor_clock;
assign kernel_monitor_reset = ~ap_rst_n;
assign kernel_monitor_clock = ap_clk;
wire [0:0] axis_block_sigs;
wire [5:0] inst_idle_sigs;
wire [3:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~phase_fetch_data_axis_ap_uint_64_16ul_0ul_0ul_ap_uint_64_U0.phasestream_TDATA_blk_n;

assign inst_idle_sigs[0] = entry_proc_U0.ap_idle;
assign inst_block_sigs[0] = (entry_proc_U0.ap_done & ~entry_proc_U0.ap_continue);
assign inst_idle_sigs[1] = phase_fetch_data_axis_ap_uint_64_16ul_0ul_0ul_ap_uint_64_U0.ap_idle;
assign inst_block_sigs[1] = (phase_fetch_data_axis_ap_uint_64_16ul_0ul_0ul_ap_uint_64_U0.ap_done & ~phase_fetch_data_axis_ap_uint_64_16ul_0ul_0ul_ap_uint_64_U0.ap_continue) | ~phase_fetch_data_axis_ap_uint_64_16ul_0ul_0ul_ap_uint_64_U0.fetched16_blk_n | ~phase_fetch_data_axis_ap_uint_64_16ul_0ul_0ul_ap_uint_64_U0.fetched_keep18_blk_n;
assign inst_idle_sigs[2] = capture_data_ap_uint_64_U0.ap_idle;
assign inst_block_sigs[2] = (capture_data_ap_uint_64_U0.ap_done & ~capture_data_ap_uint_64_U0.ap_continue) | ~capture_data_ap_uint_64_U0.fetched16_blk_n | ~capture_data_ap_uint_64_U0.fetched_keep18_blk_n | ~capture_data_ap_uint_64_U0.toout17_blk_n;
assign inst_idle_sigs[3] = put_data_csize_ap_uint_64_U0.ap_idle;
assign inst_block_sigs[3] = (put_data_csize_ap_uint_64_U0.ap_done & ~put_data_csize_ap_uint_64_U0.ap_continue) | ~put_data_csize_ap_uint_64_U0.grp_put_data_csize_ap_uint_64_Pipeline_write_fu_81.toout17_blk_n;

assign inst_idle_sigs[4] = 1'b0;
assign inst_idle_sigs[5] = phase_fetch_data_axis_ap_uint_64_16ul_0ul_0ul_ap_uint_64_U0.ap_idle;

phase_capture_hls_deadlock_idx0_monitor phase_capture_hls_deadlock_idx0_monitor_U (
    .clock(kernel_monitor_clock),
    .reset(kernel_monitor_reset),
    .axis_block_sigs(axis_block_sigs),
    .inst_idle_sigs(inst_idle_sigs),
    .inst_block_sigs(inst_block_sigs),
    .block(kernel_block)
);

