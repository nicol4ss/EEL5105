library IEEE;
use IEEE.Std_Logic_1164.all;

entity disp7seg is
    port (a: in std_logic_vector(3 downto 0);
          b: out std_logic_vector(6 downto 0)
          );
end disp7seg;

architecture disp7 of disp7seg is
    begin
        b <= "1000000" when a = "0000" else
             "1111001" when a = "0001" else
             "0100100" when a = "0010" else
             "0110000" when a = "0011" else
             "0011001" when a = "0100" else
             "0010010" when a = "0101" else
             "0000010" when a = "0110" else
             "1111000" when a = "0111" else
             "0000000" when a = "1000" else
             "0010000" when a = "1001" else
             "0001000" when a = "1010" else
             "0000011" when a = "1011" else
             "1000110" when a = "1100" else
             "0100001" when a = "1101" else
             "0000110" when a = "1110" else
             "0001110";
    end disp7;