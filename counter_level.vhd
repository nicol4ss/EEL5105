library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity counter_level is
    port(
        DATA: in std_logic_vector(3 downto 0);
        R: in std_logic;
        E: in std_logic;
        clock: in std_logic;
        end_FPGA: out std_logic
    );
end counter_level;

architecture teste of counter_level is
    signal x: std_logic_vector(3 downto 0) := "0000";

begin

    process(clock,R)
    begin
        if (R = '1') then
            x <= "0000";
            end_FPGA <= '0';
        elsif (clock'event and clock = '1') then
            if (E = '1') then
                if ( x = DATA ) then
                    end_FPGA <= '1';
                else 
                    x <= x + "0001";
                    end_FPGA <= '0';
                end if;
            end if;
        end if;
    end process;
end teste;