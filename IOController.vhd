-- IOController.vhd (hobby servo pulse generator)
-- This starting point generates a pulse between 600 us and something much longer than 2.4 ms.

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity IOController is
    port(
        CS          : in  std_logic;
        IO_WRITE    : in  std_logic;
        IO_DATA     : in  std_logic_vector(15 downto 0);
        CLOCK       : in  std_logic;
        RESETN      : in  std_logic;
        Microseconds       : out std_logic_vector(15 downto 0)
    );
end IOController;

architecture a of IOController is

	 signal scaled 	: unsigned(31 downto 0); --the value after multiplication
	 signal mult		: unsigned(15 downto 0); --the multiplicand
	 signal max			: unsigned(15 downto 0); --the max number
	 signal IO_NUM		: unsigned(15 downto 0); --the cumber coming in from scomp
	 signal corrected : unsigned(15 downto 0); --the number after max is applied

begin

    -- Latch data on rising edge of CS
    process (RESETN, CS) begin
        if RESETN = '0' then
            IO_NUM <= x"0000";
        elsif IO_WRITE = '1' and rising_edge(CS) then
            IO_NUM <= unsigned(IO_DATA);
        end if;
    end process;

	mult <= x"000A"; 				--10 in hex
	max <= x"00B4";				--180 in hex
	
	corrected <= unsigned(IO_NUM) when unsigned(IO_NUM) < max else max; --apply max value for protection
	
	scaled <= corrected * mult;	--scale the number from 0 to 180


	Microseconds <= std_logic_vector(scaled(15 downto 0) + 600); --apply output
end a;
