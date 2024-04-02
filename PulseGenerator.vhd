-- PulseGenerator.vhd (hobby servo pulse generator)
-- This starting point generates a pulse between 600 us and something much longer than 2.4 ms.

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity PulseGenerator is
    port(
        IO_DATA     : in  std_logic_vector(15 downto 0);
        CLOCK       : in  std_logic;
        RESETN      : in  std_logic;
        PULSE       : out std_logic
    );
end PulseGenerator;

architecture a of PulseGenerator is

--    signal inputLength : std_logic_vector(15 downto 0);  -- desired pulse length from IO_Bus
    signal count   : std_logic_vector(15 downto 0);  -- internal counter

begin
    process (RESETN, CLOCK)
    begin
        if (RESETN = '0') then
            count <= x"0000";
        elsif rising_edge(CLOCK) then
            -- Each clock cycle, a counter is incremented.
            count <= count + 1;

            -- When the counter reaches the full desired period, start the period over.
            if count = x"4E20" then  -- 20 ms has elapsed
                -- Reset the counter and set the output high.
                count <= x"0000";
                PULSE <= '1';

            -- Within the period, when the counter reaches the "command" value, set the output low.
            -- This will make larger command values produce longer pulses.
            elsif count = IO_DATA then
                PULSE <= '0';
            end if;
        end if;
    end process;

end a;