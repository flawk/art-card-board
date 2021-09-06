--------------------------------------------------------------------------------
--
-- art_card_Top : Top level of the ART_CARD FGPA.
-- Copyright (C) 2021  Spectracom SAS
--
-- This library is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
-- This library is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity art_card_Top is
    port
    (
        CLK_25M         : in    std_logic;
        CLK_OSC         : in    std_logic;
        PCIE_CLK_REF    : in    std_logic;
        PCIE_PIN_PERSTn : in    std_logic;
        PCIE_WAKEn      : in    std_logic;
        PCIE_TX         : out   std_logic_vector(3 downto 0);
        PCIE_RX         : in    std_logic_vector(3 downto 0);
        UART_OSC_TX     : out   std_logic;
        UART_OSC_RX     : in    std_logic;
        UART_GNSS_TX    : out   std_logic;
        UART_GNSS_RX    : in    std_logic;
        GNSS_PPS        : in    std_logic;
        LED             : out   std_logic_vector(3 downto 0);
        DAC_CLK         : out   std_logic;
        DAC_MOSI        : out   std_logic;
        DAC_CSN         : out   std_logic;
        OSC_PPS_OUT     : in    std_logic;
        OSC_PPS_IN      : out   std_logic;
        OSC_BITE        : in    std_logic;
        OSC_SDA         : inout std_logic;
        OSC_SCL         : inout std_logic;
        DCLS_IN         : in    std_logic;
        DCLS_OUT        : out   std_logic_vector(1 downto 0);
        FREQ_IN         : in    std_logic;
        GPIO            : inout std_logic_vector(3 downto 0);
        ID              : in    std_logic_vector(3 downto 0);
        EEPROM_SCL      : inout std_logic;
        EEPROM_SDA      : inout std_logic
    );
end art_card_Top;

architecture rtl of art_card_Top is

    component art_card_pd is
        port (
            clk_10m_clk                 : in  std_logic;
            in_100_clk                  : in  std_logic;
            clk_50m_clk                 : out std_logic;
            clk_200m_clk                : out std_logic;
            pll_osc_200m_reset_reset    : in  std_logic;
            clk_200m_locked_export      : out std_logic;
            reset_200m_reset            : in  std_logic;
            pll_50m_reset_reset         : in  std_logic;

            -- PCIe x4
            pcie_serial_rx_in0          : in  std_logic;
            pcie_serial_rx_in1          : in  std_logic;
            pcie_serial_rx_in2          : in  std_logic;
            pcie_serial_rx_in3          : in  std_logic;
            pcie_serial_tx_out0         : out std_logic;
            pcie_serial_tx_out1         : out std_logic;
            pcie_serial_tx_out2         : out std_logic;
            pcie_serial_tx_out3         : out std_logic;
            pcie_npor_npor              : in  std_logic;
            pcie_npor_pin_perst         : in  std_logic;

            -- mRO50 Serial
            serial_mro_tx               : out std_logic;
            serial_mro_rx               : in  std_logic;
            serial_mro_error            : out std_logic;

            -- DAC for specific oscillator
            spi_dac_MISO                : in  std_logic;
            spi_dac_MOSI                : out std_logic;
            spi_dac_SCLK                : out std_logic;
            spi_dac_SS_n                : out std_logic;

            -- EEPROM I2C
            i2c_eeprom_scl_pad_i        : in  std_logic;
            i2c_eeprom_scl_pad_o        : out std_logic;
            i2c_eeprom_scl_padoen_o     : out std_logic;
            i2c_eeprom_sda_pad_i        : in  std_logic;
            i2c_eeprom_sda_pad_o        : out std_logic;
            i2c_eeprom_sda_padoen_o     : out std_logic;

            -- GNSS Serial
            gnss_serial_stx_pad_o       : out std_logic;
            gnss_serial_srx_pad_i       : in  std_logic;
            gnss_serial_rts_pad_o       : out std_logic;
            gnss_serial_cts_pad_i       : in  std_logic;
            gnss_serial_dtr_pad_o       : out std_logic;
            gnss_serial_dsr_pad_i       : in  std_logic;
            gnss_serial_ri_pad_i        : in  std_logic;
            gnss_serial_dcd_pad_i       : in  std_logic;

            -- Phy2sys
            internal_pps_out_pps_out    : out std_logic;
            ts_phy2sys_time_s_o         : out std_logic_vector(31 downto 0);
            ts_phy2sys_time_ns_o        : out std_logic_vector(31 downto 0);

            -- Phasemeter Feature
            phasemeter_pps_gnss_pps_gnss: in  std_logic;
            phasemeter_pps_ref_pps_i    : in  std_logic;

            -- PPS Internal
            ppsout_to_pps_out           : out std_logic;
            ppsout_tref_pps_ref         : in  std_logic;
            ts_ppsout_t_time_s_o        : in  std_logic_vector(31 downto 0);
            ts_ppsout_t_time_ns_o       : in  std_logic_vector(31 downto 0);

            -- PPS Output from Internal PPS
            ppsout_ref_pps_ref          : in  std_logic;
            ppsout_o_pps_out            : out std_logic;
            ts_pps_out_time_s_o         : in  std_logic_vector(31 downto 0);
            ts_pps_out_time_ns_o        : in  std_logic_vector(31 downto 0);

            -- PPS Output from GNSS
            ppsout_gref_pps_ref          : in  std_logic;
            ppsout_go_pps_out            : out std_logic;
            ts_ppsout_g_time_s_o         : in  std_logic_vector(31 downto 0);
            ts_ppsout_g_time_ns_o        : in  std_logic_vector(31 downto 0)


        );
    end component art_card_pd;


    signal eeprom_sda_out: std_logic;
    signal eeprom_scl_out: std_logic;
    signal eeprom_sda_oe: std_logic;
    signal eeprom_scl_oe: std_logic;

    signal sUART_OSC_TX: std_logic;
    signal sUART_OSC_RX: std_logic;

    signal gnss_tx:     std_logic;
    signal led_error:   std_logic;

    signal clk_200m:    std_logic;
    signal clk_50m:     std_logic;
    signal pll_locked:  std_logic;
    signal rst_200m:    std_logic;

    signal por_rst: std_logic;
    signal por_rstn: std_logic;
    signal por_rst_cnt : unsigned(8 downto 0);
    signal pcie_npor: std_logic;

    signal internal_ref_pps: std_logic;
    signal internal_time_s : std_logic_vector(31 downto 0);
    signal internal_time_ns : std_logic_vector(31 downto 0);
    signal pps_out: std_logic;
    signal lloop: std_logic;

    signal pps_gnss_200: std_logic;
    signal pps_gnss_r_200: std_logic;
    signal pulse_gnss: std_logic;
    signal pulse_gnss_r: std_logic_vector(2 downto 0);

begin

    u0 : component art_card_pd
        port map (
            clk_10m_clk                 => CLK_OSC,
            in_100_clk                  => PCIE_CLK_REF,
            clk_50m_clk                 => clk_50m,
            clk_200m_clk                => clk_200m,
            pll_osc_200m_reset_reset    => not PCIE_PIN_PERSTn,
            pll_50m_reset_reset         => not PCIE_PIN_PERSTn,
            clk_200m_locked_export      => pll_locked,
            reset_200m_reset            => rst_200m,

            -- PCIe x4
            pcie_serial_rx_in0          => PCIE_RX(0),
            pcie_serial_rx_in1          => PCIE_RX(1),
            pcie_serial_rx_in2          => PCIE_RX(2),
            pcie_serial_rx_in3          => PCIE_RX(3),
            pcie_serial_tx_out0         => PCIE_TX(0),
            pcie_serial_tx_out1         => PCIE_TX(1),
            pcie_serial_tx_out2         => PCIE_TX(2),
            pcie_serial_tx_out3         => PCIE_TX(3),
            pcie_npor_npor              => pcie_npor,
            pcie_npor_pin_perst         => PCIE_PIN_PERSTn,
            serial_mro_tx               => sUART_OSC_TX,
            serial_mro_rx               => sUART_OSC_RX,
            serial_mro_error            => led_error,

            -- DAC for specific oscillator
            spi_dac_MISO                => '0',
            spi_dac_MOSI                => DAC_MOSI,
            spi_dac_SCLK                => DAC_CLK,
            spi_dac_SS_n                => DAC_CSN,

            -- EEPROM I2C
            i2c_eeprom_scl_pad_i        => EEPROM_SCL,
            i2c_eeprom_scl_pad_o        => eeprom_scl_out,
            i2c_eeprom_scl_padoen_o     => eeprom_scl_oe,
            i2c_eeprom_sda_pad_i        => EEPROM_SDA,
            i2c_eeprom_sda_pad_o        => eeprom_sda_out,
            i2c_eeprom_sda_padoen_o     => eeprom_sda_oe,

            -- GNSS Serial
            gnss_serial_stx_pad_o       => gnss_tx,
            gnss_serial_srx_pad_i       => UART_GNSS_RX,
            gnss_serial_rts_pad_o       => open,
            gnss_serial_cts_pad_i       => '1',
            gnss_serial_dtr_pad_o       => open,
            gnss_serial_dsr_pad_i       => '1',
            gnss_serial_ri_pad_i        => '0',
            gnss_serial_dcd_pad_i       => '1',

            -- Phy2sys
            internal_pps_out_pps_out    => internal_ref_pps,
            ts_phy2sys_time_s_o         => internal_time_s,
            ts_phy2sys_time_ns_o        => internal_time_ns,

            -- Phasemeter Feature
            phasemeter_pps_gnss_pps_gnss=> GNSS_PPS,
            phasemeter_pps_ref_pps_i    => internal_ref_pps,

            -- PPS Internal
            ppsout_tref_pps_ref         => internal_ref_pps,
            ppsout_to_pps_out           => open, --feature used only in software
            ts_ppsout_t_time_s_o        => internal_time_s,
            ts_ppsout_t_time_ns_o       => internal_time_ns,

            -- PPS Output Internal PPS
            ppsout_ref_pps_ref          => internal_ref_pps,
            ppsout_o_pps_out            => pps_out,
            ts_pps_out_time_s_o         => internal_time_s,
            ts_pps_out_time_ns_o        => internal_time_ns,

            -- PPS Output GNSS
            ppsout_gref_pps_ref         => pulse_gnss_r(2),
            ppsout_go_pps_out           => open,
            ts_ppsout_g_time_s_o        => internal_time_s,
            ts_ppsout_g_time_ns_o       => internal_time_ns
        );

    -- Power over Reset
    process(CLK_25M)
    begin
        if rising_edge(CLK_25M) then
            por_rst  <= not por_rst_cnt(8);
            por_rstn <= por_rst_cnt(8);
            if (por_rst_cnt(8) = '0') then
                por_rst_cnt <= por_rst_cnt + 1;
            end if;
        end if;
    end process;

    process(clk_200m, por_rst)
    begin
        if (por_rst = '1') then
            rst_200m <= '1';
        elsif rising_edge(clk_200m) then
            rst_200m <= not pll_locked;
        end if;
    end process;

    pcie_npor <= por_rstn;

    -- Register GNSS Pulse in 200MHz
    gnss_pulse_200: process(clk_200m, rst_200m)
    begin
        if (rst_200m = '1') then
            pps_gnss_200 <= '0';
            pps_gnss_r_200 <= '0';
        elsif rising_edge(clk_200m) then
            pps_gnss_200 <= GNSS_PPS;
            pps_gnss_r_200 <= pps_gnss_200;
            pulse_gnss <= pps_gnss_200 and not pps_gnss_r_200;
        end if;
    end process gnss_pulse_200;

    -- delay GNSS Pulse
    gnss_pulse_del: process(clk_200m, rst_200m)
    begin
        if (rst_200m = '1') then
            pulse_gnss_r <= (others => '0');
        elsif rising_edge(clk_200m) then
            pulse_gnss_r <= pulse_gnss_r(1 downto 0) & pulse_gnss;
        end if;
    end process gnss_pulse_del;


    -- LED Assignment
    LED(0) <= GNSS_PPS;
    LED(1) <= pps_out;
    LED(2) <= not gnss_tx or not UART_GNSS_RX;
    LED(3) <= led_error;

    -- DCLS Assignment
    DCLS_OUT <= GNSS_PPS & pps_out;

    -- EEPROM Assignment
    EEPROM_SCL <= eeprom_scl_out when eeprom_scl_oe = '0' else 'Z';
    EEPROM_SDA <= eeprom_sda_out when eeprom_sda_oe = '0' else 'Z';

    -- Other oscillator support (not implemented)
    OSC_SCL <= 'Z';
    OSC_SDA <= 'Z';

    -- UART Assignment
    UART_OSC_TX <= not sUART_OSC_TX;
    sUART_OSC_RX <= not UART_OSC_RX;
    UART_GNSS_TX <= gnss_tx;

    -- Test Point
    GPIO(0) <= sUART_OSC_TX;
    GPIO(1) <= sUART_OSC_RX;
    GPIO(2) <= '0';
    GPIO(3) <= '0';

end rtl;