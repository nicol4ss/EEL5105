library IEEE;
use IEEE.Std_Logic_1164.all;

entity REG_setup is
    port(
        A: in std_logic_vector(13 downto 0);
        R: in std_logic;
        E: in std_logic;
        clock: in std_logic;
        SETUP: out std_logic_vector(13 downto 0));
end REG_setup;

architecture teste of REG_setup is

begin

    process(clock,R)
    begin
        if (R = '1') then
            SETUP <= "00000000000000";
        elsif (clock'event and clock = '1') then
            if (E = '1') then
                SETUP <= A;
            end if;
        end if;
    end process;
end teste;