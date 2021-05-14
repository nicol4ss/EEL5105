library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity counter_time is
    port(
        R: in std_logic;
        E: in std_logic;
        clock: in std_logic;
        end_time: out std_logic;
        time1: out std_logic_vector(3 downto 0)
    );
end counter_time;

architecture teste of counter_time is
    signal x: std_logic_vector(3 downto 0) := "0000";

begin

    process(clock, R)
    begin
        if (R = '1') then
            x <= "0000";
            end_time <= '0';
            time1 <= x;
        elsif (clock'event and clock = '1') then
            if (E = '1') then
                if ( x = "1010" ) then
                    end_time <= '1';
                    time1 <= x;
                else 
                    x <= x + "0001";
                    end_time <= '0';
                    time1 <= x;
                end if;
            end if;
        end if;
    end process;
end teste;