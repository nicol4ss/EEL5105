library IEEE;
use IEEE.Std_Logic_1164.all;

entity HEX51 is
    port(
        E5: in std_logic;
        E6: in std_logic;
        end_round_aux: in std_logic;
        s: out std_logic_vector(6 downto 0)
    );
end HEX51;

architecture teste of HEX51 is
    signal S1,S2,V1,V2,V3,V4: std_logic_vector(6 downto 0);

    component multiplexador2x1 is
        port (a: in std_logic_vector (6 downto 0);
              b: in std_logic_vector (6 downto 0);
              c: in std_logic;
              d: out std_logic_vector(6 downto 0));
    end component;

begin

    V1 <= "1100001";
    V2 <= "1100011";
    V3 <= "0000100";
    V4 <= "0000110";

    MUX1: multiplexador2x1 port map(a => V1,
                                    b => V2,
                                    c => E5,
                                    d => S1);
    MUX2: multiplexador2x1 port map(a => V3,
                                    b => V4,
                                    c => end_round_aux,
                                    d => S2);
    MUX3: multiplexador2x1 port map(a => S1,
                                    b => S2,
                                    c => E6,
                                    d => s);
end teste;