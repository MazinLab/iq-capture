-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
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
    keep_V                :out  STD_LOGIC_VECTOR(255 downto 0);
    capturesize_V         :out  STD_LOGIC_VECTOR(31 downto 0);
    configure             :out  STD_LOGIC_VECTOR(0 downto 0)
);
end entity iq_capture_control_s_axi;

-- ------------------------Address Info-------------------
-- 0x00 : reserved
-- 0x04 : reserved
-- 0x08 : reserved
-- 0x0c : reserved
-- 0x10 : Data signal of keep_V
--        bit 31~0 - keep_V[31:0] (Read/Write)
-- 0x14 : Data signal of keep_V
--        bit 31~0 - keep_V[63:32] (Read/Write)
-- 0x18 : Data signal of keep_V
--        bit 31~0 - keep_V[95:64] (Read/Write)
-- 0x1c : Data signal of keep_V
--        bit 31~0 - keep_V[127:96] (Read/Write)
-- 0x20 : Data signal of keep_V
--        bit 31~0 - keep_V[159:128] (Read/Write)
-- 0x24 : Data signal of keep_V
--        bit 31~0 - keep_V[191:160] (Read/Write)
-- 0x28 : Data signal of keep_V
--        bit 31~0 - keep_V[223:192] (Read/Write)
-- 0x2c : Data signal of keep_V
--        bit 31~0 - keep_V[255:224] (Read/Write)
-- 0x30 : reserved
-- 0x34 : Data signal of capturesize_V
--        bit 31~0 - capturesize_V[31:0] (Read/Write)
-- 0x38 : reserved
-- 0x3c : Data signal of configure
--        bit 0  - configure[0] (Read/Write)
--        others - reserved
-- 0x40 : reserved
-- (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

architecture behave of iq_capture_control_s_axi is
    type states is (wridle, wrdata, wrresp, wrreset, rdidle, rddata, rdreset);  -- read and write fsm states
    signal wstate  : states := wrreset;
    signal rstate  : states := rdreset;
    signal wnext, rnext: states;
    constant ADDR_KEEP_V_DATA_0        : INTEGER := 16#10#;
    constant ADDR_KEEP_V_DATA_1        : INTEGER := 16#14#;
    constant ADDR_KEEP_V_DATA_2        : INTEGER := 16#18#;
    constant ADDR_KEEP_V_DATA_3        : INTEGER := 16#1c#;
    constant ADDR_KEEP_V_DATA_4        : INTEGER := 16#20#;
    constant ADDR_KEEP_V_DATA_5        : INTEGER := 16#24#;
    constant ADDR_KEEP_V_DATA_6        : INTEGER := 16#28#;
    constant ADDR_KEEP_V_DATA_7        : INTEGER := 16#2c#;
    constant ADDR_KEEP_V_CTRL          : INTEGER := 16#30#;
    constant ADDR_CAPTURESIZE_V_DATA_0 : INTEGER := 16#34#;
    constant ADDR_CAPTURESIZE_V_CTRL   : INTEGER := 16#38#;
    constant ADDR_CONFIGURE_DATA_0     : INTEGER := 16#3c#;
    constant ADDR_CONFIGURE_CTRL       : INTEGER := 16#40#;
    constant ADDR_BITS         : INTEGER := 7;

    signal waddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal wmask               : UNSIGNED(31 downto 0);
    signal aw_hs               : STD_LOGIC;
    signal w_hs                : STD_LOGIC;
    signal rdata_data          : UNSIGNED(31 downto 0);
    signal ar_hs               : STD_LOGIC;
    signal raddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal AWREADY_t           : STD_LOGIC;
    signal WREADY_t            : STD_LOGIC;
    signal ARREADY_t           : STD_LOGIC;
    signal RVALID_t            : STD_LOGIC;
    -- internal registers
    signal int_keep_V          : UNSIGNED(255 downto 0) := (others => '0');
    signal int_capturesize_V   : UNSIGNED(31 downto 0) := (others => '0');
    signal int_configure       : UNSIGNED(0 downto 0) := (others => '0');


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
                    case (TO_INTEGER(raddr)) is
                    when ADDR_KEEP_V_DATA_0 =>
                        rdata_data <= RESIZE(int_keep_V(31 downto 0), 32);
                    when ADDR_KEEP_V_DATA_1 =>
                        rdata_data <= RESIZE(int_keep_V(63 downto 32), 32);
                    when ADDR_KEEP_V_DATA_2 =>
                        rdata_data <= RESIZE(int_keep_V(95 downto 64), 32);
                    when ADDR_KEEP_V_DATA_3 =>
                        rdata_data <= RESIZE(int_keep_V(127 downto 96), 32);
                    when ADDR_KEEP_V_DATA_4 =>
                        rdata_data <= RESIZE(int_keep_V(159 downto 128), 32);
                    when ADDR_KEEP_V_DATA_5 =>
                        rdata_data <= RESIZE(int_keep_V(191 downto 160), 32);
                    when ADDR_KEEP_V_DATA_6 =>
                        rdata_data <= RESIZE(int_keep_V(223 downto 192), 32);
                    when ADDR_KEEP_V_DATA_7 =>
                        rdata_data <= RESIZE(int_keep_V(255 downto 224), 32);
                    when ADDR_CAPTURESIZE_V_DATA_0 =>
                        rdata_data <= RESIZE(int_capturesize_V(31 downto 0), 32);
                    when ADDR_CONFIGURE_DATA_0 =>
                        rdata_data <= RESIZE(int_configure(0 downto 0), 32);
                    when others =>
                        rdata_data <= (others => '0');
                    end case;
                end if;
            end if;
        end if;
    end process;

-- ----------------------- Register logic ----------------
    keep_V               <= STD_LOGIC_VECTOR(int_keep_V);
    capturesize_V        <= STD_LOGIC_VECTOR(int_capturesize_V);
    configure            <= STD_LOGIC_VECTOR(int_configure);

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_KEEP_V_DATA_0) then
                    int_keep_V(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep_V(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_KEEP_V_DATA_1) then
                    int_keep_V(63 downto 32) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep_V(63 downto 32));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_KEEP_V_DATA_2) then
                    int_keep_V(95 downto 64) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep_V(95 downto 64));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_KEEP_V_DATA_3) then
                    int_keep_V(127 downto 96) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep_V(127 downto 96));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_KEEP_V_DATA_4) then
                    int_keep_V(159 downto 128) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep_V(159 downto 128));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_KEEP_V_DATA_5) then
                    int_keep_V(191 downto 160) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep_V(191 downto 160));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_KEEP_V_DATA_6) then
                    int_keep_V(223 downto 192) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep_V(223 downto 192));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_KEEP_V_DATA_7) then
                    int_keep_V(255 downto 224) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_keep_V(255 downto 224));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_CAPTURESIZE_V_DATA_0) then
                    int_capturesize_V(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_capturesize_V(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_CONFIGURE_DATA_0) then
                    int_configure(0 downto 0) <= (UNSIGNED(WDATA(0 downto 0)) and wmask(0 downto 0)) or ((not wmask(0 downto 0)) and int_configure(0 downto 0));
                end if;
            end if;
        end if;
    end process;


-- ----------------------- Memory logic ------------------

end architecture behave;
