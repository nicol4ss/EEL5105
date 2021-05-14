library IEEE;
use IEEE.Std_Logic_1164.all;

entity multiplexador4x1 is
    port (a: in std_logic_vector (17 downto 0);
          b: in std_logic_vector (17 downto 0);
          c: in std_logic_vector (17 downto 0);
          d: in std_logic_vector (17 downto 0);
          e: in std_logic_vector (1 downto 0);
          saida: out std_logic_vector(17 downto 0));
end multiplexador4x1;

architecture multiplex of multiplexador4x1 is

    begin
        with e select saida <= a when "00",
                               b when "01",
                               c when "10",
                               d when others;

    end multiplex;