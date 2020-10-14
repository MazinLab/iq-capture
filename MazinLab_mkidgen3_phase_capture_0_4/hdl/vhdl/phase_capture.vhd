-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2019.2.1
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity phase_capture is
generic (
    C_S_AXI_CONTROL_ADDR_WIDTH : INTEGER := 7;
    C_S_AXI_CONTROL_DATA_WIDTH : INTEGER := 32 );
port (
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    phasestream_TDATA : IN STD_LOGIC_VECTOR (63 downto 0);
    phasestream_TVALID : IN STD_LOGIC;
    phasestream_TREADY : OUT STD_LOGIC;
    phasestream_TUSER : IN STD_LOGIC_VECTOR (8 downto 0);
    phasestream_TLAST : IN STD_LOGIC;
    streamid_V : IN STD_LOGIC_VECTOR (2 downto 0);
    phaseout_TDATA : OUT STD_LOGIC_VECTOR (63 downto 0);
    phaseout_TVALID : OUT STD_LOGIC;
    phaseout_TREADY : IN STD_LOGIC;
    phaseout_TID : OUT STD_LOGIC_VECTOR (2 downto 0);
    phaseout_TLAST : OUT STD_LOGIC;
    s_axi_control_AWVALID : IN STD_LOGIC;
    s_axi_control_AWREADY : OUT STD_LOGIC;
    s_axi_control_AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_ADDR_WIDTH-1 downto 0);
    s_axi_control_WVALID : IN STD_LOGIC;
    s_axi_control_WREADY : OUT STD_LOGIC;
    s_axi_control_WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_DATA_WIDTH-1 downto 0);
    s_axi_control_WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_DATA_WIDTH/8-1 downto 0);
    s_axi_control_ARVALID : IN STD_LOGIC;
    s_axi_control_ARREADY : OUT STD_LOGIC;
    s_axi_control_ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_CONTROL_ADDR_WIDTH-1 downto 0);
    s_axi_control_RVALID : OUT STD_LOGIC;
    s_axi_control_RREADY : IN STD_LOGIC;
    s_axi_control_RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_CONTROL_DATA_WIDTH-1 downto 0);
    s_axi_control_RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
    s_axi_control_BVALID : OUT STD_LOGIC;
    s_axi_control_BREADY : IN STD_LOGIC;
    s_axi_control_BRESP : OUT STD_LOGIC_VECTOR (1 downto 0) );
end;


architecture behav of phase_capture is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "phase_capture,hls_ip_2019_2_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xczu28dr-ffvg1517-2-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=1.672000,HLS_SYN_LAT=3,HLS_SYN_TPT=1,HLS_SYN_MEM=2,HLS_SYN_DSP=0,HLS_SYN_FF=807,HLS_SYN_LUT=2100,HLS_VERSION=2019_2_1}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant C_S_AXI_DATA_WIDTH : INTEGER range 63 downto 0 := 20;
    constant ap_const_lv9_0 : STD_LOGIC_VECTOR (8 downto 0) := "000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv256_lc_1 : STD_LOGIC_VECTOR (255 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001";
    constant ap_const_lv256_lc_2 : STD_LOGIC_VECTOR (255 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv32_FFFFFFFF : STD_LOGIC_VECTOR (31 downto 0) := "11111111111111111111111111111111";

    signal ap_rst_n_inv : STD_LOGIC;
    signal keep_V : STD_LOGIC_VECTOR (255 downto 0);
    signal capturesize_V : STD_LOGIC_VECTOR (31 downto 0);
    signal configure : STD_LOGIC;
    signal p_remaining_V : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    signal p_aligned : STD_LOGIC_VECTOR (0 downto 0) := "0";
    signal phasestream_TDATA_blk_n : STD_LOGIC;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal phaseout_TDATA_blk_n : STD_LOGIC;
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal configure_read_reg_215 : STD_LOGIC_VECTOR (0 downto 0);
    signal configure_read_reg_215_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln54_reg_254 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_s_reg_258 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_enable_reg_pp0_iter3 : STD_LOGIC := '0';
    signal configure_read_reg_215_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln54_reg_254_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_s_reg_258_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal configure_read_read_fu_74_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter2 : BOOLEAN;
    signal ap_predicate_op31_write_state3 : BOOLEAN;
    signal ap_block_state3_io : BOOLEAN;
    signal regslice_both_phaseout_data_V_U_apdone_blk : STD_LOGIC;
    signal ap_block_state4_pp0_stage0_iter3 : BOOLEAN;
    signal ap_predicate_op51_write_state4 : BOOLEAN;
    signal ap_block_state4_io : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal capturesize_V_read_reg_224 : STD_LOGIC_VECTOR (31 downto 0);
    signal keep_V_read_reg_229 : STD_LOGIC_VECTOR (255 downto 0);
    signal phasestream_data_V_t_reg_234 : STD_LOGIC_VECTOR (63 downto 0);
    signal phasestream_data_V_t_reg_234_pp0_iter1_reg : STD_LOGIC_VECTOR (63 downto 0);
    signal phasein_user_V_reg_239 : STD_LOGIC_VECTOR (8 downto 0);
    signal icmp_ln879_fu_129_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln879_reg_244 : STD_LOGIC_VECTOR (0 downto 0);
    signal phasetmp_last_fu_139_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal phasetmp_last_reg_249 : STD_LOGIC_VECTOR (0 downto 0);
    signal and_ln54_fu_166_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal p_Result_s_fu_186_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal add_ln701_fu_192_p2 : STD_LOGIC_VECTOR (31 downto 0);
    signal or_ln47_fu_149_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal icmp_ln895_fu_160_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal zext_ln791_fu_172_p1 : STD_LOGIC_VECTOR (255 downto 0);
    signal shl_ln791_fu_175_p2 : STD_LOGIC_VECTOR (255 downto 0);
    signal and_ln791_fu_181_p2 : STD_LOGIC_VECTOR (255 downto 0);
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal regslice_both_phasestream_data_V_U_apdone_blk : STD_LOGIC;
    signal phasestream_TDATA_int : STD_LOGIC_VECTOR (63 downto 0);
    signal phasestream_TVALID_int : STD_LOGIC;
    signal phasestream_TREADY_int : STD_LOGIC;
    signal regslice_both_phasestream_data_V_U_ack_in : STD_LOGIC;
    signal regslice_both_phasestream_user_V_U_apdone_blk : STD_LOGIC;
    signal phasestream_TUSER_int : STD_LOGIC_VECTOR (8 downto 0);
    signal regslice_both_phasestream_user_V_U_vld_out : STD_LOGIC;
    signal regslice_both_phasestream_user_V_U_ack_in : STD_LOGIC;
    signal regslice_both_w1_phasestream_last_U_apdone_blk : STD_LOGIC;
    signal phasestream_TLAST_int : STD_LOGIC;
    signal regslice_both_w1_phasestream_last_U_vld_out : STD_LOGIC;
    signal regslice_both_w1_phasestream_last_U_ack_in : STD_LOGIC;
    signal phaseout_TVALID_int : STD_LOGIC;
    signal phaseout_TREADY_int : STD_LOGIC;
    signal regslice_both_phaseout_data_V_U_vld_out : STD_LOGIC;
    signal regslice_both_phaseout_id_V_U_apdone_blk : STD_LOGIC;
    signal regslice_both_phaseout_id_V_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_phaseout_id_V_U_vld_out : STD_LOGIC;
    signal regslice_both_w1_phaseout_last_U_apdone_blk : STD_LOGIC;
    signal phaseout_TLAST_int : STD_LOGIC;
    signal regslice_both_w1_phaseout_last_U_ack_in_dummy : STD_LOGIC;
    signal regslice_both_w1_phaseout_last_U_vld_out : STD_LOGIC;
    signal ap_condition_176 : BOOLEAN;
    signal ap_condition_178 : BOOLEAN;

    component phase_capture_control_s_axi IS
    generic (
        C_S_AXI_ADDR_WIDTH : INTEGER;
        C_S_AXI_DATA_WIDTH : INTEGER );
    port (
        AWVALID : IN STD_LOGIC;
        AWREADY : OUT STD_LOGIC;
        AWADDR : IN STD_LOGIC_VECTOR (C_S_AXI_ADDR_WIDTH-1 downto 0);
        WVALID : IN STD_LOGIC;
        WREADY : OUT STD_LOGIC;
        WDATA : IN STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
        WSTRB : IN STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH/8-1 downto 0);
        ARVALID : IN STD_LOGIC;
        ARREADY : OUT STD_LOGIC;
        ARADDR : IN STD_LOGIC_VECTOR (C_S_AXI_ADDR_WIDTH-1 downto 0);
        RVALID : OUT STD_LOGIC;
        RREADY : IN STD_LOGIC;
        RDATA : OUT STD_LOGIC_VECTOR (C_S_AXI_DATA_WIDTH-1 downto 0);
        RRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        BVALID : OUT STD_LOGIC;
        BREADY : IN STD_LOGIC;
        BRESP : OUT STD_LOGIC_VECTOR (1 downto 0);
        ACLK : IN STD_LOGIC;
        ARESET : IN STD_LOGIC;
        ACLK_EN : IN STD_LOGIC;
        keep_V : OUT STD_LOGIC_VECTOR (255 downto 0);
        capturesize_V : OUT STD_LOGIC_VECTOR (31 downto 0);
        configure : OUT STD_LOGIC );
    end component;


    component regslice_both IS
    generic (
        DataWidth : INTEGER );
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR (DataWidth-1 downto 0);
        vld_in : IN STD_LOGIC;
        ack_in : OUT STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR (DataWidth-1 downto 0);
        vld_out : OUT STD_LOGIC;
        ack_out : IN STD_LOGIC;
        apdone_blk : OUT STD_LOGIC );
    end component;


    component regslice_both_w1 IS
    generic (
        DataWidth : INTEGER );
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        data_in : IN STD_LOGIC;
        vld_in : IN STD_LOGIC;
        ack_in : OUT STD_LOGIC;
        data_out : OUT STD_LOGIC;
        vld_out : OUT STD_LOGIC;
        ack_out : IN STD_LOGIC;
        apdone_blk : OUT STD_LOGIC );
    end component;



begin
    phase_capture_control_s_axi_U : component phase_capture_control_s_axi
    generic map (
        C_S_AXI_ADDR_WIDTH => C_S_AXI_CONTROL_ADDR_WIDTH,
        C_S_AXI_DATA_WIDTH => C_S_AXI_CONTROL_DATA_WIDTH)
    port map (
        AWVALID => s_axi_control_AWVALID,
        AWREADY => s_axi_control_AWREADY,
        AWADDR => s_axi_control_AWADDR,
        WVALID => s_axi_control_WVALID,
        WREADY => s_axi_control_WREADY,
        WDATA => s_axi_control_WDATA,
        WSTRB => s_axi_control_WSTRB,
        ARVALID => s_axi_control_ARVALID,
        ARREADY => s_axi_control_ARREADY,
        ARADDR => s_axi_control_ARADDR,
        RVALID => s_axi_control_RVALID,
        RREADY => s_axi_control_RREADY,
        RDATA => s_axi_control_RDATA,
        RRESP => s_axi_control_RRESP,
        BVALID => s_axi_control_BVALID,
        BREADY => s_axi_control_BREADY,
        BRESP => s_axi_control_BRESP,
        ACLK => ap_clk,
        ARESET => ap_rst_n_inv,
        ACLK_EN => ap_const_logic_1,
        keep_V => keep_V,
        capturesize_V => capturesize_V,
        configure => configure);

    regslice_both_phasestream_data_V_U : component regslice_both
    generic map (
        DataWidth => 64)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        data_in => phasestream_TDATA,
        vld_in => phasestream_TVALID,
        ack_in => regslice_both_phasestream_data_V_U_ack_in,
        data_out => phasestream_TDATA_int,
        vld_out => phasestream_TVALID_int,
        ack_out => phasestream_TREADY_int,
        apdone_blk => regslice_both_phasestream_data_V_U_apdone_blk);

    regslice_both_phasestream_user_V_U : component regslice_both
    generic map (
        DataWidth => 9)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        data_in => phasestream_TUSER,
        vld_in => phasestream_TVALID,
        ack_in => regslice_both_phasestream_user_V_U_ack_in,
        data_out => phasestream_TUSER_int,
        vld_out => regslice_both_phasestream_user_V_U_vld_out,
        ack_out => phasestream_TREADY_int,
        apdone_blk => regslice_both_phasestream_user_V_U_apdone_blk);

    regslice_both_w1_phasestream_last_U : component regslice_both_w1
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        data_in => phasestream_TLAST,
        vld_in => phasestream_TVALID,
        ack_in => regslice_both_w1_phasestream_last_U_ack_in,
        data_out => phasestream_TLAST_int,
        vld_out => regslice_both_w1_phasestream_last_U_vld_out,
        ack_out => phasestream_TREADY_int,
        apdone_blk => regslice_both_w1_phasestream_last_U_apdone_blk);

    regslice_both_phaseout_data_V_U : component regslice_both
    generic map (
        DataWidth => 64)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        data_in => phasestream_data_V_t_reg_234_pp0_iter1_reg,
        vld_in => phaseout_TVALID_int,
        ack_in => phaseout_TREADY_int,
        data_out => phaseout_TDATA,
        vld_out => regslice_both_phaseout_data_V_U_vld_out,
        ack_out => phaseout_TREADY,
        apdone_blk => regslice_both_phaseout_data_V_U_apdone_blk);

    regslice_both_phaseout_id_V_U : component regslice_both
    generic map (
        DataWidth => 3)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        data_in => streamid_V,
        vld_in => phaseout_TVALID_int,
        ack_in => regslice_both_phaseout_id_V_U_ack_in_dummy,
        data_out => phaseout_TID,
        vld_out => regslice_both_phaseout_id_V_U_vld_out,
        ack_out => phaseout_TREADY,
        apdone_blk => regslice_both_phaseout_id_V_U_apdone_blk);

    regslice_both_w1_phaseout_last_U : component regslice_both_w1
    generic map (
        DataWidth => 1)
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        data_in => phaseout_TLAST_int,
        vld_in => phaseout_TVALID_int,
        ack_in => regslice_both_w1_phaseout_last_U_ack_in_dummy,
        data_out => phaseout_TLAST,
        vld_out => regslice_both_w1_phaseout_last_U_vld_out,
        ack_out => phaseout_TREADY,
        apdone_blk => regslice_both_w1_phaseout_last_U_apdone_blk);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter3_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst_n_inv = '1') then
                ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
                end if; 
            end if;
        end if;
    end process;


    p_aligned_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_1 = ap_condition_176)) then
                if ((configure_read_reg_215 = ap_const_lv1_1)) then 
                    p_aligned <= ap_const_lv1_0;
                elsif ((configure_read_reg_215 = ap_const_lv1_0)) then 
                    p_aligned <= or_ln47_fu_149_p2;
                end if;
            end if; 
        end if;
    end process;

    p_remaining_V_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_1 = ap_condition_176)) then
                if ((configure_read_reg_215 = ap_const_lv1_1)) then 
                    p_remaining_V <= capturesize_V_read_reg_224;
                elsif ((ap_const_boolean_1 = ap_condition_178)) then 
                    p_remaining_V <= add_ln701_fu_192_p2;
                end if;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((configure_read_reg_215 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                and_ln54_reg_254 <= and_ln54_fu_166_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_0 = ap_block_pp0_stage0_11001)) then
                and_ln54_reg_254_pp0_iter2_reg <= and_ln54_reg_254;
                configure_read_reg_215_pp0_iter2_reg <= configure_read_reg_215_pp0_iter1_reg;
                p_Result_s_reg_258_pp0_iter2_reg <= p_Result_s_reg_258;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                capturesize_V_read_reg_224 <= capturesize_V;
                configure_read_reg_215 <= (0=>configure, others=>'-');
                configure_read_reg_215_pp0_iter1_reg <= configure_read_reg_215;
                keep_V_read_reg_229 <= keep_V;
                phasein_user_V_reg_239 <= phasestream_TUSER_int;
                phasestream_data_V_t_reg_234 <= phasestream_TDATA_int;
                phasestream_data_V_t_reg_234_pp0_iter1_reg <= phasestream_data_V_t_reg_234;
                phasetmp_last_reg_249 <= phasetmp_last_fu_139_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((configure_read_read_fu_74_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                icmp_ln879_reg_244 <= icmp_ln879_fu_129_p2;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_lv1_1 = and_ln54_fu_166_p2) and (configure_read_reg_215 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then
                p_Result_s_reg_258 <= p_Result_s_fu_186_p2;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_CS_fsm, ap_block_pp0_stage0_subdone, ap_reset_idle_pp0)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_pp0_stage0 => 
                ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
            when others =>  
                ap_NS_fsm <= "X";
        end case;
    end process;
    add_ln701_fu_192_p2 <= std_logic_vector(unsigned(p_remaining_V) + unsigned(ap_const_lv32_FFFFFFFF));
    and_ln54_fu_166_p2 <= (or_ln47_fu_149_p2 and icmp_ln895_fu_160_p2);
    and_ln791_fu_181_p2 <= (shl_ln791_fu_175_p2 and keep_V_read_reg_229);
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(ap_enable_reg_pp0_iter3, regslice_both_phaseout_data_V_U_apdone_blk, phasestream_TVALID_int)
    begin
                ap_block_pp0_stage0_01001 <= (((ap_enable_reg_pp0_iter3 = ap_const_logic_1) and (regslice_both_phaseout_data_V_U_apdone_blk = ap_const_logic_1)) or ((phasestream_TVALID_int = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_1)));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3, ap_block_state3_io, regslice_both_phaseout_data_V_U_apdone_blk, ap_block_state4_io, phasestream_TVALID_int)
    begin
                ap_block_pp0_stage0_11001 <= (((ap_enable_reg_pp0_iter3 = ap_const_logic_1) and ((ap_const_boolean_1 = ap_block_state4_io) or (regslice_both_phaseout_data_V_U_apdone_blk = ap_const_logic_1))) or ((ap_const_boolean_1 = ap_block_state3_io) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((phasestream_TVALID_int = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_1)));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3, ap_block_state3_io, regslice_both_phaseout_data_V_U_apdone_blk, ap_block_state4_io, phasestream_TVALID_int)
    begin
                ap_block_pp0_stage0_subdone <= (((ap_enable_reg_pp0_iter3 = ap_const_logic_1) and ((ap_const_boolean_1 = ap_block_state4_io) or (regslice_both_phaseout_data_V_U_apdone_blk = ap_const_logic_1))) or ((ap_const_boolean_1 = ap_block_state3_io) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)) or ((phasestream_TVALID_int = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_1)));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(phasestream_TVALID_int)
    begin
                ap_block_state1_pp0_stage0_iter0 <= (phasestream_TVALID_int = ap_const_logic_0);
    end process;

        ap_block_state2_pp0_stage0_iter1 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state3_io_assign_proc : process(ap_predicate_op31_write_state3, phaseout_TREADY_int)
    begin
                ap_block_state3_io <= ((phaseout_TREADY_int = ap_const_logic_0) and (ap_predicate_op31_write_state3 = ap_const_boolean_1));
    end process;

        ap_block_state3_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state4_io_assign_proc : process(ap_predicate_op51_write_state4, phaseout_TREADY_int)
    begin
                ap_block_state4_io <= ((phaseout_TREADY_int = ap_const_logic_0) and (ap_predicate_op51_write_state4 = ap_const_boolean_1));
    end process;


    ap_block_state4_pp0_stage0_iter3_assign_proc : process(regslice_both_phaseout_data_V_U_apdone_blk)
    begin
                ap_block_state4_pp0_stage0_iter3 <= (regslice_both_phaseout_data_V_U_apdone_blk = ap_const_logic_1);
    end process;


    ap_condition_176_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001, ap_enable_reg_pp0_iter1)
    begin
                ap_condition_176 <= ((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001));
    end process;


    ap_condition_178_assign_proc : process(configure_read_reg_215, and_ln54_fu_166_p2, p_Result_s_fu_186_p2)
    begin
                ap_condition_178 <= ((ap_const_lv1_1 = and_ln54_fu_166_p2) and (configure_read_reg_215 = ap_const_lv1_0) and (p_Result_s_fu_186_p2 = ap_const_lv1_0));
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter2, ap_enable_reg_pp0_iter3, ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter3 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_predicate_op31_write_state3_assign_proc : process(configure_read_reg_215_pp0_iter1_reg, and_ln54_reg_254, p_Result_s_reg_258)
    begin
                ap_predicate_op31_write_state3 <= ((ap_const_lv1_1 = and_ln54_reg_254) and (p_Result_s_reg_258 = ap_const_lv1_0) and (configure_read_reg_215_pp0_iter1_reg = ap_const_lv1_0));
    end process;


    ap_predicate_op51_write_state4_assign_proc : process(configure_read_reg_215_pp0_iter2_reg, and_ln54_reg_254_pp0_iter2_reg, p_Result_s_reg_258_pp0_iter2_reg)
    begin
                ap_predicate_op51_write_state4 <= ((ap_const_lv1_1 = and_ln54_reg_254_pp0_iter2_reg) and (p_Result_s_reg_258_pp0_iter2_reg = ap_const_lv1_0) and (configure_read_reg_215_pp0_iter2_reg = ap_const_lv1_0));
    end process;

    ap_reset_idle_pp0 <= ap_const_logic_0;

    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;

    configure_read_read_fu_74_p2 <= (0=>configure, others=>'-');
    icmp_ln879_fu_129_p2 <= "1" when (phasestream_TUSER_int = ap_const_lv9_0) else "0";
    icmp_ln895_fu_160_p2 <= "0" when (p_remaining_V = ap_const_lv32_0) else "1";
    or_ln47_fu_149_p2 <= (p_aligned or icmp_ln879_reg_244);
    p_Result_s_fu_186_p2 <= "1" when (and_ln791_fu_181_p2 = ap_const_lv256_lc_2) else "0";

    phaseout_TDATA_blk_n_assign_proc : process(ap_block_pp0_stage0, ap_enable_reg_pp0_iter2, configure_read_reg_215_pp0_iter1_reg, and_ln54_reg_254, p_Result_s_reg_258, ap_enable_reg_pp0_iter3, configure_read_reg_215_pp0_iter2_reg, and_ln54_reg_254_pp0_iter2_reg, p_Result_s_reg_258_pp0_iter2_reg, phaseout_TREADY_int)
    begin
        if ((((ap_const_lv1_1 = and_ln54_reg_254_pp0_iter2_reg) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (p_Result_s_reg_258_pp0_iter2_reg = ap_const_lv1_0) and (configure_read_reg_215_pp0_iter2_reg = ap_const_lv1_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1)) or ((ap_const_lv1_1 = and_ln54_reg_254) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (p_Result_s_reg_258 = ap_const_lv1_0) and (configure_read_reg_215_pp0_iter1_reg = ap_const_lv1_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1)))) then 
            phaseout_TDATA_blk_n <= phaseout_TREADY_int;
        else 
            phaseout_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    phaseout_TLAST_int <= phasetmp_last_reg_249(0);
    phaseout_TVALID <= regslice_both_phaseout_data_V_U_vld_out;

    phaseout_TVALID_int_assign_proc : process(ap_enable_reg_pp0_iter2, ap_predicate_op31_write_state3, ap_block_pp0_stage0_11001)
    begin
        if (((ap_predicate_op31_write_state3 = ap_const_boolean_1) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            phaseout_TVALID_int <= ap_const_logic_1;
        else 
            phaseout_TVALID_int <= ap_const_logic_0;
        end if; 
    end process;


    phasestream_TDATA_blk_n_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, phasestream_TVALID_int)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            phasestream_TDATA_blk_n <= phasestream_TVALID_int;
        else 
            phasestream_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    phasestream_TREADY_assign_proc : process(phasestream_TVALID, regslice_both_phasestream_data_V_U_ack_in)
    begin
        if (((phasestream_TVALID = ap_const_logic_1) and (regslice_both_phasestream_data_V_U_ack_in = ap_const_logic_1))) then 
            phasestream_TREADY <= ap_const_logic_1;
        else 
            phasestream_TREADY <= ap_const_logic_0;
        end if; 
    end process;


    phasestream_TREADY_int_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_logic_1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001))) then 
            phasestream_TREADY_int <= ap_const_logic_1;
        else 
            phasestream_TREADY_int <= ap_const_logic_0;
        end if; 
    end process;

    phasetmp_last_fu_139_p2 <= "1" when (p_remaining_V = ap_const_lv32_1) else "0";
    shl_ln791_fu_175_p2 <= std_logic_vector(shift_left(unsigned(ap_const_lv256_lc_1),to_integer(unsigned('0' & zext_ln791_fu_172_p1(31-1 downto 0)))));
    zext_ln791_fu_172_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(phasein_user_V_reg_239),256));
end behav;