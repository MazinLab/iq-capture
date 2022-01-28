-- ==============================================================
-- RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Version: 2021.1
-- Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity filter_iq is
generic (
    C_S_AXI_CONTROL_ADDR_WIDTH : INTEGER := 6;
    C_S_AXI_CONTROL_DATA_WIDTH : INTEGER := 32 );
port (
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    instream_TDATA : IN STD_LOGIC_VECTOR (255 downto 0);
    instream_TVALID : IN STD_LOGIC;
    instream_TREADY : OUT STD_LOGIC;
    instream_TKEEP : IN STD_LOGIC_VECTOR (31 downto 0);
    instream_TSTRB : IN STD_LOGIC_VECTOR (31 downto 0);
    instream_TUSER : IN STD_LOGIC_VECTOR (7 downto 0);
    instream_TLAST : IN STD_LOGIC_VECTOR (0 downto 0);
    outstream_TDATA : OUT STD_LOGIC_VECTOR (255 downto 0);
    outstream_TVALID : OUT STD_LOGIC;
    outstream_TREADY : IN STD_LOGIC;
    outstream_TKEEP : OUT STD_LOGIC_VECTOR (31 downto 0);
    outstream_TSTRB : OUT STD_LOGIC_VECTOR (31 downto 0);
    outstream_TLAST : OUT STD_LOGIC_VECTOR (0 downto 0);
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


architecture behav of filter_iq is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "filter_iq_filter_iq,hls_ip_2021_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu21dr-ffvd1156-1-e,HLS_INPUT_CLOCK=1.818000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=1.000000,HLS_SYN_LAT=1,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=581,HLS_SYN_LUT=605,HLS_VERSION=2021_1}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant C_S_AXI_DATA_WIDTH : INTEGER range 63 downto 0 := 20;
    constant ap_const_lv32_FFFFFFFF : STD_LOGIC_VECTOR (31 downto 0) := "11111111111111111111111111111111";

    signal ap_rst_n_inv : STD_LOGIC;
    signal keep : STD_LOGIC_VECTOR (255 downto 0);
    signal lastgrp : STD_LOGIC_VECTOR (7 downto 0);
    signal instream_TDATA_blk_n : STD_LOGIC;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (0 downto 0) := "1";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal outstream_TDATA_blk_n : STD_LOGIC;
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal p_keep_reg_148 : STD_LOGIC_VECTOR (0 downto 0);
    signal lastgrp_read_reg_133 : STD_LOGIC_VECTOR (7 downto 0);
    signal ap_block_state1_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state2_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state2_io : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal tmp_reg_138 : STD_LOGIC_VECTOR (255 downto 0);
    signal tmp_3_reg_143 : STD_LOGIC_VECTOR (7 downto 0);
    signal p_keep_fetch_keep_fu_112_ap_return : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal p_keep_fetch_keep_fu_112_ap_ready : STD_LOGIC;
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal ap_NS_fsm : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_reset_idle_pp0 : STD_LOGIC;
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;
    signal ap_ce_reg : STD_LOGIC;

    component filter_iq_fetch_keep IS
    port (
        ap_ready : OUT STD_LOGIC;
        keep : IN STD_LOGIC_VECTOR (255 downto 0);
        grp : IN STD_LOGIC_VECTOR (7 downto 0);
        ap_return : OUT STD_LOGIC_VECTOR (0 downto 0) );
    end component;


    component filter_iq_control_s_axi IS
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
        keep : OUT STD_LOGIC_VECTOR (255 downto 0);
        lastgrp : OUT STD_LOGIC_VECTOR (7 downto 0) );
    end component;



begin
    p_keep_fetch_keep_fu_112 : component filter_iq_fetch_keep
    port map (
        ap_ready => p_keep_fetch_keep_fu_112_ap_ready,
        keep => keep,
        grp => instream_TUSER,
        ap_return => p_keep_fetch_keep_fu_112_ap_return);

    control_s_axi_U : component filter_iq_control_s_axi
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
        keep => keep,
        lastgrp => lastgrp);





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
                if (((ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                    ap_enable_reg_pp0_iter1 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;

    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                lastgrp_read_reg_133 <= lastgrp;
                p_keep_reg_148 <= p_keep_fetch_keep_fu_112_ap_return;
                tmp_3_reg_143 <= instream_TUSER;
                tmp_reg_138 <= instream_TDATA;
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
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(0);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(instream_TVALID, outstream_TREADY, ap_enable_reg_pp0_iter1, p_keep_reg_148)
    begin
                ap_block_pp0_stage0_01001 <= (((instream_TVALID = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_1)) or ((p_keep_reg_148 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (outstream_TREADY = ap_const_logic_0)));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(instream_TVALID, outstream_TREADY, ap_enable_reg_pp0_iter1, p_keep_reg_148, ap_block_state2_io)
    begin
                ap_block_pp0_stage0_11001 <= (((instream_TVALID = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and ((ap_const_boolean_1 = ap_block_state2_io) or ((p_keep_reg_148 = ap_const_lv1_1) and (outstream_TREADY = ap_const_logic_0)))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(instream_TVALID, outstream_TREADY, ap_enable_reg_pp0_iter1, p_keep_reg_148, ap_block_state2_io)
    begin
                ap_block_pp0_stage0_subdone <= (((instream_TVALID = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and ((ap_const_boolean_1 = ap_block_state2_io) or ((p_keep_reg_148 = ap_const_lv1_1) and (outstream_TREADY = ap_const_logic_0)))));
    end process;


    ap_block_state1_pp0_stage0_iter0_assign_proc : process(instream_TVALID)
    begin
                ap_block_state1_pp0_stage0_iter0 <= (instream_TVALID = ap_const_logic_0);
    end process;


    ap_block_state2_io_assign_proc : process(outstream_TREADY, p_keep_reg_148)
    begin
                ap_block_state2_io <= ((p_keep_reg_148 = ap_const_lv1_1) and (outstream_TREADY = ap_const_logic_0));
    end process;


    ap_block_state2_pp0_stage0_iter1_assign_proc : process(outstream_TREADY, p_keep_reg_148)
    begin
                ap_block_state2_pp0_stage0_iter1 <= ((p_keep_reg_148 = ap_const_lv1_1) and (outstream_TREADY = ap_const_logic_0));
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter1)
    begin
        if (((ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_const_logic_1 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;

    ap_reset_idle_pp0 <= ap_const_logic_0;

    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;


    instream_TDATA_blk_n_assign_proc : process(instream_TVALID, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            instream_TDATA_blk_n <= instream_TVALID;
        else 
            instream_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    instream_TREADY_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            instream_TREADY <= ap_const_logic_1;
        else 
            instream_TREADY <= ap_const_logic_0;
        end if; 
    end process;

    outstream_TDATA <= tmp_reg_138;

    outstream_TDATA_blk_n_assign_proc : process(outstream_TREADY, ap_CS_fsm_pp0_stage0, ap_block_pp0_stage0, ap_enable_reg_pp0_iter1, p_keep_reg_148)
    begin
        if (((p_keep_reg_148 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            outstream_TDATA_blk_n <= outstream_TREADY;
        else 
            outstream_TDATA_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    outstream_TKEEP <= ap_const_lv32_FFFFFFFF;
    outstream_TLAST <= "1" when (tmp_3_reg_143 = lastgrp_read_reg_133) else "0";
    outstream_TSTRB <= ap_const_lv32_0;

    outstream_TVALID_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, p_keep_reg_148, ap_block_pp0_stage0_11001)
    begin
        if (((p_keep_reg_148 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            outstream_TVALID <= ap_const_logic_1;
        else 
            outstream_TVALID <= ap_const_logic_0;
        end if; 
    end process;

end behav;
