library IEEE;
use IEEE.Std_Logic_1164.all;

entity multiplexador2x1_7 is
    port (a: in std_logic_vector (17 downto 0);
          b: in std_logic_vector (17 downto 0);
          c: in std_logic;
          d: out std_logic_vector(17 downto 0));
end multiplexador2x1_7;

architecture multiplex of multiplexador2x1_7 is

    begin
        with c select d <= a when '0',
                           b when others;

    end multiplex;