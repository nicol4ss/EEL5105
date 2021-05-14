library IEEE;
use IEEE.Std_Logic_1164.all;

entity decBCD is
    port(
        a: in std_logic_vector(3 downto 0);
        b: out std_logic_vector(7 downto 0)
    );
end decBCD;

architecture teste of decBCD is

begin

    b <= "00000000" when a = "0000" else
         "00000001" when a = "0001" else
         "00000010" when a = "0010" else
         "00000011" when a = "0011" else
         "00000100" when a = "0100" else
         "00000101" when a = "0101" else
         "00000110" when a = "0110" else
         "00000111" when a = "0111" else
         "00001000" when a = "1000" else
         "00001001" when a = "1001" else
         "00010000" when a = "1010" else
         "00010001" when a = "1011" else
         "00010010" when a = "1100" else
         "00010011" when a = "1101" else
         "00010100" when a = "1110" else
         "00010101";

end teste;