library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity counter_round is
    port(data: in std_logic_vector(3 downto 0);
        SET: in std_logic;
        E: in std_logic;
        clock: in std_logic;
        end_round: out std_logic;
        round1: out std_logic_vector(3 downto 0)
    );
end counter_round;

architecture teste of counter_round is
    signal x: std_logic_vector(3 downto 0);
    signal endround: std_logic;
    signal x1: std_logic_vector(3 downto 0);
begin
    process(clock,SET)
    begin
        if (SET = '1') then
            x <= data;
            endround <= '0';
        elsif (clock'event and clock = '1') then
            if (E = '1') then
                if ( x = "0000" ) then
                    endround <= '1';
                    x1 <= x;
                else 
                    x <= x - "0001";
                    endround <= '0';
                    x1 <= x;
                end if;
            end if;
        end if;
    end process;
    end_round <= endround;
    round1 <= x1;
end teste;