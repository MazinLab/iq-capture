
wire kernel_monitor_reset;
wire kernel_monitor_clock;
assign kernel_monitor_reset = ~ap_rst_n;
assign kernel_monitor_clock = ap_clk;
wire [1:0] axis_block_sigs;
wire [5:0] inst_idle_sigs;
wire [2:0] inst_block_sigs;
wire kernel_block;

assign axis_block_sigs[0] = ~pair_iq_df_flat_U0.grp_pair_iq_df_flat_Pipeline_read_fu_58.istream_V_TDATA_blk_n;
assign axis_block_sigs[1] = ~pair_iq_df_flat_U0.grp_pair_iq_df_flat_Pipeline_read_fu_58.qstream_V_TDATA_blk_n;

assign inst_idle_sigs[0] = entry_proc_U0.ap_idle;
assign inst_block_sigs[0] = (entry_proc_U0.ap_done & ~entry_proc_U0.ap_continue);
assign inst_idle_sigs[1] = pair_iq_df_flat_U0.ap_idle;
assign inst_block_sigs[1] = (pair_iq_df_flat_U0.ap_done & ~pair_iq_df_flat_U0.ap_continue) | ~pair_iq_df_flat_U0.grp_pair_iq_df_flat_Pipeline_read_fu_58.iq_in8_blk_n | ~pair_iq_df_flat_U0.capturesize_c_blk_n;
assign inst_idle_sigs[2] = put_data_csize_ap_uint_256_U0.ap_idle;
assign inst_block_sigs[2] = (put_data_csize_ap_uint_256_U0.ap_done & ~put_data_csize_ap_uint_256_U0.ap_continue) | ~put_data_csize_ap_uint_256_U0.grp_put_data_csize_ap_uint_256_Pipeline_write_fu_77.iq_in8_blk_n | ~put_data_csize_ap_uint_256_U0.capturesize_blk_n;

assign inst_idle_sigs[3] = 1'b0;
assign inst_idle_sigs[4] = pair_iq_df_flat_U0.ap_idle;
assign inst_idle_sigs[5] = pair_iq_df_flat_U0.grp_pair_iq_df_flat_Pipeline_read_fu_58.ap_idle;

adc_capture_hls_deadlock_idx0_monitor adc_capture_hls_deadlock_idx0_monitor_U (
    .clock(kernel_monitor_clock),
    .reset(kernel_monitor_reset),
    .axis_block_sigs(axis_block_sigs),
    .inst_idle_sigs(inst_idle_sigs),
    .inst_block_sigs(inst_block_sigs),
    .block(kernel_block)
);

