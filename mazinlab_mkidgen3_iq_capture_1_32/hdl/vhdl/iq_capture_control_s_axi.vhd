-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity iq_capture_control_s_axi is
generic (
    C_S_AXI_ADDR_WIDTH    : INTEGER := 7;
    C_S_AXI_DATA_WIDTH    : INTEGER := 32);
port (
    ACLK                  :in   STD_LOGIC;
    ARESET                :in   STD_LOGIC;
    ACLK_EN               :in   STD_LOGIC;
    AWADDR                :in   STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH-1 downto 0);
    AWVALID               :in   STD_LOGIC;
    AWREADY               :out  STD_LOGIC;
    WDATA                 :in   STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
    WSTRB                 :in   STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH/8-1 downto 0);
    WVALID                :in   STD_LOGIC;
    WREADY                :out  STD_LOGIC;
    BRESP                 :out  STD_LOGIC_VECTOR(1 downto 0);
    BVALID                :out  STD_LOGIC;
    BREADY                :in   STD_LOGIC;
    ARADDR                :in   STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH-1 downto 0);
    ARVALID               :in   STD_LOGIC;
    ARREADY               :out  STD_LOGIC;
    RDATA                 :out  STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
    RRESP                 :out  STD_LOGIC_VECTOR(1 downto 0);
    RVALID                :out  STD_LOGIC;
    RREADY                :in   STD_LOGIC;
    interrupt             :out  STD_LOGIC;
    clk                   :in   STD_LOGIC;
    rst                   :in   STD_LOGIC;
    keep                  :out  STD_LOGIC_VECTOR(255 downto 0);
    total_capturesize     :out  STD_LOGIC_VECTOR(34 downto 0);
    capturesize           :out  STD_LOGIC_VECTOR(26 downto 0);
    iqout                 :out  STD_LOGIC_VECTOR(63 downto 0);
    ap_start              :out  STD_LOGIC;
    ap_done               :in   STD_LOGIC;
    ap_ready              :in   STD_LOGIC;
    ap_idle               :in   STD_LOGIC
);
end entity iq_capture_control_s_axi;

-- ------------------------Address Info-------------------
-- 0x00 : Control signals
--        bit 0  - ap_start (Read/Write/COH)
--        bit 1  - ap_done (Read/COR)
--        bit 2  - ap_idle (Read)
--        bit 3  - ap_ready (Read/COR)
--        bit 7  - auto_restart (Read/Write)
--        others - reserved
-- 0x04 : Global Interrupt Enable Register
--        bit 0  - Global Interrupt Enable (Read/Write)
--        others - reserved
-- 0x08 : IP Interrupt Enable Register (Read/Write)
--        bit 0  - enable ap_done interrupt (Read/Write)
--        bit 1  - enable ap_ready interrupt (Read/Write)
--        others - reserved
-- 0x0c : IP Interrupt Status Register (Read/TOW)
--        bit 0  - ap_done (COR/TOW)
--        bit 1  - ap_ready (COR/TOW)
--        others - reserved
-- 0x10 : Data signal of keep
--        bit 31~0 - keep[31:0] (Read/Write)
-- 0x14 : Data signal of keep
--        bit 31~0 - keep[63:32] (Read/Write)
-- 0x18 : Data signal of keep
--        bit 31~0 - keep[95:64] (Read/Write)
-- 0x1c : Data signal of keep
--        bit 31~0 - keep[127:96] (Read/Write)
-- 0x20 : Data signal of keep
--        bit 31~0 - keep[159:128] (Read/Write)
-- 0x24 : Data signal of keep
--        bit 31~0 - keep[191:160] (Read/Write)
-- 0x28 : Data signal of keep
--        bit 31~0 - keep[223:192] (Read/Write)
-- 0x2c : Data signal of keep
--        bit 31~0 - keep[255:224] (Read/Write)
-- 0x30 : reserved
-- 0x34 : Data signal of total_capturesize
--        bit 31~0 - total_capturesize[31:0] (Read/Write)
-- 0x38 : Data signal of total_capturesize
--        bit 2~0 - total_capturesize[34:32] (Read/Write)
--        others  - reserved
-- 0x3c : reserved
-- 0x40 : Data signal of capturesize
--        bit 26~0 - capturesize[26:0] (Read/Write)
--        others   - reserved
-- 0x44 : reserved
-- 0x48 : Data signal of iqout
--        bit 31~0 - iqout[31:0] (Read/Write)
-- 0x4c : Data signal of iqout
--        bit 31~0 - iqout[63:32] (Read/Write)
-- 0x50 : reserved
-- (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

architecture behave of iq_capture_control_s_axi is
    type states is (wridle, wrdata, wrresp, wrreset, rdidle, rddata, rdreset);  -- read and write fsm states
    signal wstate  : states := wrreset;
    signal rstate  : states := rdreset;
    signal wnext, rnext: states;
    constant ADDR_AP_CTRL                  : INTEGER := 16#00#;
    constant ADDR_GIE                      : INTEGER := 16#04#;
    constant ADDR_IER                      : INTEGER := 16#08#;
    constant ADDR_ISR                      : INTEGER := 16#0c#;
    constant ADDR_KEEP_DATA_0              : INTEGER := 16#10#;
    constant ADDR_KEEP_DATA_1              : INTEGER := 16#14#;
    constant ADDR_KEEP_DATA_2              : INTEGER := 16#18#;
    constant ADDR_KEEP_DATA_3              : INTEGER := 16#1c#;
    constant ADDR_KEEP_DATA_4              : INTEGER := 16#20#;
    constant ADDR_KEEP_DATA_5              : INTEGER := 16#24#;
    constant ADDR_KEEP_DATA_6              : INTEGER := 16#28#;
    constant ADDR_KEEP_DATA_7              : INTEGER := 16#2c#;
    constant ADDR_KEEP_CTRL                : INTEGER := 16#30#;
    constant ADDR_TOTAL_CAPTURESIZE_DATA_0 : INTEGER := 16#34#;
    constant ADDR_TOTAL_CAPTURESIZE_DATA_1 : INTEGER := 16#38#;
    constant ADDR_TOTAL_CAPTURESIZE_CTRL   : INTEGER := 16#3c#;
    constant ADDR_CAPTURESIZE_DATA_0       : INTEGER := 16#40#;
    constant ADDR_CAPTURESIZE_CTRL         : INTEGER := 16#44#;
    constant ADDR_IQOUT_DATA_0             : INTEGER := 16#48#;
    constant ADDR_IQOUT_DATA_1             : INTEGER := 16#4c#;
    constant ADDR_IQOUT_CTRL               : INTEGER := 16#50#;
    constant ADDR_BITS         : INTEGER := 7;

    signal waddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal wmask               : UNSIGNED(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal aw_hs               : STD_LOGIC;
    signal w_hs                : STD_LOGIC;
    signal rdata_data          : UNSIGNED(C_S_AXI_DATA_WIDTH-1 downto 0);
    signal ar_hs               : STD_LOGIC;
    signal raddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal AWREADY_t           : STD_LOGIC;
    signal WREADY_t            : STD_LOGIC;
    signal ARREADY_t           : STD_LOGIC;
    signal RVALID_t            : STD_LOGIC;
    -- internal registers
    signal int_ap_idle         : STD_LOGIC := '0';
    signal int_ap_ready        : STD_LOGIC := '0';
    signal int_ap_done         : STD_LOGIC := '0';
    signal ap_done_get         : STD_LOGIC;
    signal ap_done_ext         : STD_LOGIC;
    signal int_ap_start        : STD_LOGIC := '0';
    signal ap_start_set        : STD_LOGIC;
    signal ap_start_mask       : STD_LOGIC;
    signal int_auto_restart    : STD_LOGIC := '0';
    signal auto_restart_set    : STD_LOGIC;
    signal int_gie             : STD_LOGIC := '0';
    signal int_ier             : UNSIGNED(1 downto 0) := (others => '0');
    signal ier_toggle          : STD_LOGIC;
    signal ier_mask            : STD_LOGIC;
    signal int_isr             : UNSIGNED(1 downto 0) := (others => '0');
    signal isr_toggle          : STD_LOGIC;
    signal isr_mask            : STD_LOGIC;
    signal int_keep            : UNSIGNED(255 downto 0) := (others => '0');
    signal int_total_capturesize : UNSIGNED(34 downto 0) := (others => '0');
    signal int_capturesize     : UNSIGNED(26 downto 0) := (others => '0');
    signal int_iqout           : UNSIGNED(63 downto 0) := (others => '0');


begin
-- ----------------------- Instantiation------------------


-- ----------------------- AXI WRITE ---------------------
    AWREADY_t <=  '1' when wstate = wridle else '0';
    AWREADY   <=  AWREADY_t;
    WREADY_t  <=  '1' when wstate = wrdata else '0';
    WREADY    <=  WREADY_t;
    BRESP     <=  "00";  -- OKAY
    BVALID    <=  '1' when wstate = wrresp else '0';
    wmask     <=  (31 downto 24 => WSTRB(3), 23 downto 16 => WSTRB(2), 15 downto 8 => WSTRB(1), 7 downto 0 => WSTRB(0));
    aw_hs     <=  AWVALID and AWREADY_t;
    w_hs      <=  WVALID and WREADY_t;

    -- write FSM
    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                wstate <= wrreset;
            elsif (ACLK_EN = '1') then
                wstate <= wnext;
            end if;
        end if;
    end process;

    process (wstate, AWVALID, WVALID, BREADY)
    begin
        case (wstate) is
        when wridle =>
            if (AWVALID = '1') then
                wnext <= wrdata;
            else
                wnext <= wridle;
            end if;
        when wrdata =>
            if (WVALID = '1') then
                wnext <= wrresp;
            else
                wnext <= wrdata;
            end if;
        when wrresp =>
            if (BREADY = '1') then
                wnext <= wridle;
            else
                wnext <= wrresp;
            end if;
        when others =>
            wnext <= wridle;
        end case;
    end process;

    waddr_proc : process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (aw_hs = '1') then
                    waddr <= UNSIGNED(AWADDR(ADDR_BITS-1 downto 0));
                end if;
            end if;
        end if;
    end process;

-- ----------------------- AXI READ ----------------------
    ARREADY_t <= '1' when (rstate = rdidle) else '0';
    ARREADY <= ARREADY_t;
    RDATA   <= STD_LOGIC_VECTOR(rdata_data);
    RRESP   <= "00";  -- OKAY
    RVALID_t  <= '1' when (rstate = rddata) else '0';
    RVALID    <= RVALID_t;
    ar_hs   <= ARVALID and ARREADY_t;
    raddr   <= UNSIGNED(ARADDR(ADDR_BITS-1 downto 0));

    -- read FSM
    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                rstate <= rdreset;
            elsif (ACLK_EN = '1') then
                rstate <= rnext;
            end if;
        end if;
    end process;

    process (rstate, ARVALID, RREADY, RVALID_t)
    begin
        case (rstate) is
        when rdidle =>
            if (ARVALID = '1') then
                rnext <= rddata;
            else
                rnext <= rdidle;
            end if;
        when rddata =>
            if (RREADY = '1' and RVALID_t = '1') then
                rnext <= rdidle;
            else
                rnext <= rddata;
            end if;
        when others =>
            rnext <= rdidle;
        end case;
    end process;

    rdata_proc : process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (ar_hs = '1') then
                    rdata_data <= (others => '0');
                    case (TO_INTEGER(raddr)) is
                    when ADDR_AP_CTRL =>
                        rdata_data(7) <= int_auto_restart;
                        rdata_data(3) <= int_ap_ready;
                        rdata_data(2) <= int_ap_idle;
                        rdata_data(1) <= int_ap_done;
                        rdata_data(0) <= int_ap_start;
                    when ADDR_GIE =>
                        rdata_data(0) <= int_gie;
                    when ADDR_IER =>
                        rdata_data(1 downto 0) <= int_ier;
                    when ADDR_ISR =>
                        rdata_data(1 downto 0) <= int_isr;
                    when ADDR_KEEP_DATA_0 =>
                        rdata_data <= RESIZE(int_keep(31 downto 0), 32);
                    when ADDR_KEEP_DATA_1 =>
                        rdata_data <= RESIZE(int_keep(63 downto 32), 32);
                    when ADDR_KEEP_DATA_2 =>
                        rdata_data <= RESIZE(int_keep(95 downto 64), 32);
                    when ADDR_KEEP_DATA_3 =>
                        rdata_data <= RESIZE(int_keep(127 downto 96), 32);
                    when ADDR_KEEP_DATA_4 =>
                        rdata_data <= RESIZE(int_keep(159 downto 128), 32);
                    when ADDR_KEEP_DATA_5 =>
                        rdata_data <= RESIZE(int_keep(191 downto 160), 32);
                    when ADDR_KEEP_DATA_6 =>
                        rdata_data <= RESIZE(int_keep(223 downto 192), 32);
                    when ADDR_KEEP_DATA_7 =>
                        rdata_data <= RESIZE(int_keep(255 downto 224), 32);
                    when ADDR_TOTAL_CAPTURESIZE_DATA_0 =>
                        rdata_data <= RESIZE(int_total_capturesize(31 downto 0), 32);
                    when ADDR_TOTAL_CAPTURESIZE_DATA_1 =>
                        rdata_data <= RESIZE(int_total_capturesize(34 downto 32), 32);
                    when ADDR_CAPTURESIZE_DATA_0 =>
                        rdata_data <= RESIZE(int_capturesize(26 downto 0), 32);
                    when ADDR_IQOUT_DATA_0 =>
                        rdata_data <= RESIZE(int_iqout(31 downto 0), 32);
                    when ADDR_IQOUT_DATA_1 =>
                        rdata_data <= RESIZE(int_iqout(63 downto 32), 32);
                    when others =>
                        NULL;
                    end case;
                end if;
            end if;
        end if;
    end process;

-- ----------------------- Register logic ----------------
    interrupt            <= int_gie and (int_isr(0) or int_isr(1));
    ap_start             <= int_ap_start;
    ap_start_set         <= '1' when w_hs = '1' and waddr = ADDR_AP_CTRL and WSTRB(0) = '1' and WDATA(0) = '1' else '0';
    ap_done_get          <= '1' when ar_hs = '1' and raddr = ADDR_AP_CTRL and int_ap_done = '1' else '0';
    auto_restart_set     <= '1' when w_hs = '1' and waddr = ADDR_AP_CTRL and WSTRB(0) = '1' else '0';
    isr_toggle           <= '1' when w_hs = '1' and waddr = ADDR_ISR and WSTRB(0) = '1' else '0';
    keep                 <= STD_LOGIC_VECTOR(int_keep);
    total_capturesize    <= STD_LOGIC_VECTOR(int_total_capturesize);
    capturesize          <= STD_LOGIC_VECTOR(int_capturesize);
    iqout                <= STD_LOGIC_VECTOR(int_iqout);

    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 ap_start_mask <= '0';
             else
                 ap_start_mask <= ap_start_set;
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 int_ap_start <= '0';
             elsif (ap_start_set = '1' and ap_start_mask = '0') then
                 int_ap_start <= '1';
             elsif (ap_ready = '1') then
                 int_ap_start <= int_auto_restart; -- clear on handshake/auto restart
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 ap_done_ext <= '0';
             else
                 ap_done_ext <= ap_done_get;
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 int_ap_done <= '0';
             elsif (ap_done = '1') then
                 int_ap_done <= '1';
             elsif (ap_done_get = '0' and ap_done_ext = '1') then
                 int_ap_done <= '0'; -- clear on read
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 int_ap_idle <= '0';
             else
                 int_ap_idle <= ap_idle;
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 int_ap_ready <= '0';
             else
                 int_ap_ready <= ap_ready;
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 int_auto_restart <= '0';
             elsif (auto_restart_set = '1') then
                 int_auto_restart <= WDATA(7);
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 int_gie <= '0';
             elsif (w_hs = '1' and waddr = ADDR_GIE and WSTRB(0) = '1') then
                 int_gie <= WDATA(0);
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 int_ier <= "00";
             elsif (w_hs = '1' and waddr = ADDR_IER and WSTRB(0) = '1') then
                 int_ier <= UNSIGNED(WDATA(1 downto 0));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 isr_mask <= '1';
             else
                 isr_mask <= isr_toggle;
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 int_isr(0) <= '0';
             elsif (int_ier(0) = '1' and ap_done = '1') then
                 int_isr(0) <= '1';
             elsif (isr_toggle = '1' and isr_mask = '0') then
                 int_isr(0) <= int_isr(0) xor WDATA(0); -- toggle on write
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (rst = '1') then
                 int_isr(1) <= '0';
             elsif (int_ier(1) = '1' and ap_ready = '1') then
                 int_isr(1) <= '1';
             elsif (isr_toggle = '1' and isr_mask = '0') then
                 int_isr(1) <= int_isr(1) xor WDATA(1); -- toggle on write
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_KEEP_DATA_0) then
                 int_keep(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep(31 downto 0));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_KEEP_DATA_1) then
                 int_keep(63 downto 32) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep(63 downto 32));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_KEEP_DATA_2) then
                 int_keep(95 downto 64) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep(95 downto 64));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_KEEP_DATA_3) then
                 int_keep(127 downto 96) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep(127 downto 96));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_KEEP_DATA_4) then
                 int_keep(159 downto 128) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep(159 downto 128));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_KEEP_DATA_5) then
                 int_keep(191 downto 160) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep(191 downto 160));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_KEEP_DATA_6) then
                 int_keep(223 downto 192) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep(223 downto 192));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_KEEP_DATA_7) then
                 int_keep(255 downto 224) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep(255 downto 224));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_TOTAL_CAPTURESIZE_DATA_0) then
                 int_total_capturesize(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_total_capturesize(31 downto 0));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_TOTAL_CAPTURESIZE_DATA_1) then
                 int_total_capturesize(34 downto 32) <= (UNSIGNED(WDATA(2 downto 0)) and wmask(2 downto 0)) or ((not wmask(2 downto 0)) and int_total_capturesize(34 downto 32));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_CAPTURESIZE_DATA_0) then
                 int_capturesize(26 downto 0) <= (UNSIGNED(WDATA(26 downto 0)) and wmask(26 downto 0)) or ((not wmask(26 downto 0)) and int_capturesize(26 downto 0));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_IQOUT_DATA_0) then
                 int_iqout(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_iqout(31 downto 0));
            end if;
        end if;
    end process;
    process (clk)
    begin
        if (clk'event and clk = '1') then
             if (w_hs = '1' and waddr = ADDR_IQOUT_DATA_1) then
                 int_iqout(63 downto 32) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_iqout(63 downto 32));
            end if;
        end if;
    end process;

-- ----------------------- Memory logic ------------------

end architecture behave;
