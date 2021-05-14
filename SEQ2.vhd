library ieee;
use ieee.std_logic_1164.all;
entity SEQ2 is
  port ( address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(17 downto 0) );
end entity;

architecture Rom_Arch of SEQ2 is
  type memory is array (00 to 15) of std_logic_vector(17 downto 0);
  constant my_Rom : memory := (
    00 => "000000111100001111",
    01 => "111000111000101010",
  02 => "100000000000111100",
    03 => "011010101111111110",
    04 => "010101011111110001",
    05 => "111001100110011001",
    06 => "101010111100101000",
    07 => "110000001111100000",
    08 => "100001100110000110",
    09 => "111011101110000010",
    10 => "011001100000111101",
    11 => "001001000011001111",
    12 => "101010111110001101",
    13 => "101010110011001100",
    14 => "011001100010001000",
    15 => "011111100000111110");
    
begin
   process (address) --//o adress vai ser o número da rodada.
   begin
     case address is
       when "0000" => data <= my_rom(00);
       when "0001" => data <= my_rom(01);
       when "0010" => data <= my_rom(02);
       when "0011" => data <= my_rom(03);
       when "0100" => data <= my_rom(04);
       when "0101" => data <= my_rom(05);
       when "0110" => data <= my_rom(06);
       when "0111" => data <= my_rom(07);
       when "1000" => data <= my_rom(08);
       when "1001" => data <= my_rom(09);
       when "1010" => data <= my_rom(10);
       when "1011" => data <= my_rom(11);
       when "1100" => data <= my_rom(12);
       when "1101" => data <= my_rom(13);
       when "1110" => data <= my_rom(14);
       when others => data <= my_rom(15);
       end case;
  end process;
end architecture Rom_Arch;