library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity counter_bonus is
    port(data: in std_logic_vector(5 downto 0);
        DATA2: in std_logic_vector(5 downto 0);
        SET: in std_logic;
        E: in std_logic;
        clock: in std_logic;
        end_bonus: out std_logic;
        BONUS: out std_logic_vector(5 downto 0)
    );
end counter_bonus;

architecture teste of counter_bonus is
    signal x: std_logic_vector(5 downto 0);
    signal endbonus: std_logic;
begin
    process(clock,SET,E)
    begin
        if (SET = '1') then
            x <= DATA2;
            endbonus <= '0';
        elsif (clock'event and clock = '1') then
            if (E = '1') then
                    x <= x - data;
                    endbonus <= '0';
            end if;
        end if;
    end process;
    
    end_bonus <= '1' when (x(5) = '1') else '0';
        
    BONUS <= x;
end teste;