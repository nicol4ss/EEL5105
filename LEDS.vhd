library IEEE;
use IEEE.Std_Logic_1164.all;

entity LEDS is
    port(
        a: in std_logic_vector(17 downto 0);
        b: in std_logic_vector(17 downto 0);
        e2: in std_logic;
        s: out std_logic_vector(17 downto 0)
    );
end LEDS;

architecture teste of LEDS is

    component multiplexador2x1_7 is
        port (a: in std_logic_vector (17 downto 0);
              b: in std_logic_vector (17 downto 0);
              c: in std_logic;
              d: out std_logic_vector(17 downto 0));
    end component;

begin

    MUL: multiplexador2x1_7 port map(a => a,
                                   b => b,
                                   c => e2,
                                   d => s);
end teste;