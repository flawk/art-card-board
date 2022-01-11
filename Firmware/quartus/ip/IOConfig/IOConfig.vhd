--------------------------------------------------------------------------------
--
-- IOCOnfig : Set the switch configuration
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

-- Hardware Switch Mapping
-- 0 -- In/Out 1PPS IO0
-- 1 -- In/Out 1PPS IO1
-- 2 -- In/Out 1PPS IO2
-- 3 -- In/Out 1PPS IO3
-- 4 -- 1PPS/Out 10MHz  IO0
-- 5 -- 1PPS/In 10MHz   IO1

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity IOCOnfig is
    port (
        RST_I:          in   std_logic;
        CLK_I:          in   std_logic;
        ADDR_I:         in   std_logic_vector(3 downto 0);
        DATA_O:         out  std_logic_vector(31 downto 0);
        DATA_I:         in   std_logic_vector(31 downto 0);
        RD_I:           in   std_logic;
        WR_I:           in   std_logic;
        SWITCH_PIN:     out  std_logic_vector(5 downto 0);
        CONFIG_IO_OUT:  out  std_logic_vector(3 downto 0)
        );
    end IOCOnfig;

architecture rtl_IOCOnfig of IOCOnfig is

    -- Address Decoding
    constant CST_ADDR_IO0:      std_logic_vector(3 downto 0)    := x"0";
    constant CST_ADDR_IO1:      std_logic_vector(3 downto 0)    := x"4";
    constant CST_ADDR_IO2:      std_logic_vector(3 downto 0)    := x"8";
    constant CST_ADDR_IO3:      std_logic_vector(3 downto 0)    := x"C";

    constant CST_CAP_IO0:       std_logic_vector(15 downto 0)   := x"001F";		--1PPS In/Out/Out GNSS | 10Mhz Out
    constant CST_CAP_IO1:       std_logic_vector(15 downto 0)   := x"000F";		--1PPS In/Out/Out GNSS | 10Mhz In
    constant CST_CAP_IO2:       std_logic_vector(15 downto 0)   := x"0003";		--1PPS In/Out/Out GNSS
    constant CST_CAP_IO3:       std_logic_vector(15 downto 0)   := x"0003";		--1PPS In/Out/Out GNSS

    constant CST_IO_IN_1PPS:    std_logic_vector(15 downto 0)   := x"0001";
    constant CST_IO_OUT_1PPS:   std_logic_vector(15 downto 0)   := x"0002";
    constant CST_IO_OUT_GNSS:   std_logic_vector(15 downto 0)   := x"0004";
    constant CST_IO_IN_10MHZ:   std_logic_vector(15 downto 0)   := x"0008";
    constant CST_IO_OUT_10MHZ:  std_logic_vector(15 downto 0)   := x"0010";

    signal reg_io0: std_logic_vector(15 downto 0);
    signal reg_io1: std_logic_vector(15 downto 0);
    signal reg_io2: std_logic_vector(15 downto 0);
    signal reg_io3: std_logic_vector(15 downto 0);

    signal config_sw: std_logic_vector(5 downto 0);
    signal config_io: std_logic_vector(3 downto 0);

begin

    -- CPU access
    -------------
    process (RST_I, CLK_I)
    begin
        if (RST_I = '1') then
            reg_io0 <= CST_IO_IN_1PPS;
            reg_io1 <= CST_IO_IN_1PPS;
            reg_io2 <= CST_IO_IN_1PPS;
            reg_io3 <= CST_IO_IN_1PPS;
            DATA_O <= (others => '0');
        elsif rising_edge(CLK_I) then
            DATA_O <= (others => '0');
            if (RD_I = '1') then
                case ADDR_I is
                    when CST_ADDR_IO0 =>
                        DATA_O <= CST_CAP_IO0 & reg_io0;
                    when CST_ADDR_IO1 =>
                        DATA_O <= CST_CAP_IO1 & reg_io1;
                    when CST_ADDR_IO2 =>
                        DATA_O <= CST_CAP_IO2 & reg_io2;
                    when CST_ADDR_IO3 =>
                        DATA_O <= CST_CAP_IO3 & reg_io3;
                    when others =>
                        null;
                end case;
            end if;
            if (WR_I = '1') then
                case ADDR_I is
                    when CST_ADDR_IO0 =>
                        reg_io0 <= DATA_I(15 downto 0);
                    when CST_ADDR_IO1 =>
                        reg_io1 <= DATA_I(15 downto 0);
                    when CST_ADDR_IO2 =>
                        reg_io2 <= DATA_I(15 downto 0);
                    when CST_ADDR_IO3 =>
                        reg_io3 <= DATA_I(15 downto 0);
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process;

    -- Configure Switch
    -------------------
    process (RST_I, CLK_I)
    begin
        if (RST_I = '1') then
            config_sw <= (others => '0');
            config_io <= (others => '0');
        elsif rising_edge(CLK_I) then
            -- IO0
            case (reg_io0) is
                when CST_IO_OUT_1PPS =>
                    config_sw(0) <= '1';
                    config_sw(4) <= '0';
                    config_io(0) <= '0';
                when CST_IO_OUT_GNSS =>
                    config_sw(0) <= '1';
                    config_sw(4) <= '0';
                    config_io(0) <= '1';
                when CST_IO_OUT_10MHZ =>
                    config_sw(0) <= '0';
                    config_sw(4) <= '1';
                    config_io(0) <= '0';
                when others =>
                    config_sw(0) <= '0';
                    config_sw(4) <= '0';
                    config_io(0) <= '0';
            end case;
            -- IO1
            case (reg_io1) is
                when CST_IO_OUT_1PPS =>
                    config_sw(1) <= '1';
                    config_sw(5) <= '0';
                    config_io(1) <= '0';
                when CST_IO_OUT_GNSS =>
                    config_sw(1) <= '1';
                    config_sw(5) <= '0';
                    config_io(1) <= '1';
                when CST_IO_OUT_10MHZ =>
                    config_sw(1) <= '0';
                    config_sw(5) <= '1';
                    config_io(1) <= '0';
                when others =>
                    config_sw(1) <= '0';
                    config_sw(5) <= '0';
                    config_io(1) <= '0';
            end case;
            -- IO2
            case (reg_io2) is
                when CST_IO_OUT_1PPS =>
                    config_sw(2) <= '1';
                    config_io(2) <= '0';
                when CST_IO_OUT_GNSS =>
                    config_sw(2) <= '1';
                    config_io(2) <= '1';
                when others =>
                    config_sw(2) <= '0';
                    config_io(2) <= '0';
            end case;
            -- IO3
            case (reg_io3) is
                when CST_IO_OUT_1PPS =>
                    config_sw(3) <= '1';
                    config_io(3) <= '0';
                when CST_IO_OUT_GNSS =>
                    config_sw(3) <= '1';
                    config_io(3) <= '1';
                when others =>
                    config_sw(3) <= '0';
                    config_io(3) <= '0';
            end case;
        end if;
    end process;

    SWITCH_PIN <= config_sw;
    CONFIG_IO_OUT <= config_sw(3 downto 0);

end rtl_IOCOnfig;