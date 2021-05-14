library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_signed.all;

entity datapath is
port(sw_entra: in std_logic_vector(17 downto 0);
r1, e1,e2,e3,e4,e5, e6, clk1, clk50, key_entra: in std_logic;
h0, h1, h2, h3, h4, h5, h6, h7: out std_logic_vector(6 downto 0);
led_out: out std_logic_vector (17 downto 0);
end_time, end_bonus, end_round, end_FPGA: out std_logic);

end datapath;

architecture arqdata of datapath is
    signal SETUP: std_logic_vector(13 downto 0);
    signal time1: std_logic_vector(3 downto 0);
    signal round1: std_logic_vector(3 downto 0);
    signal end_round1: std_logic;
    signal X1: std_logic;
    signal X2: std_logic_vector(5 downto 0);
    signal X3: std_logic;
    signal X4: std_logic_vector(17 downto 0);
    signal X5: std_logic_vector(17 downto 0);
    signal ROUND_BCD: std_logic_vector(7 downto 0);
    signal S1: std_logic_vector(17 downto 0);
    signal S2: std_logic_vector(17 downto 0);
    signal S3: std_logic_vector(17 downto 0);
    signal S4: std_logic_vector(17 downto 0);
    signal SEQ_FGPA: std_logic_vector(17 downto 0);
    signal nao_aguento_mais_signal: std_logic_vector(5 downto 0);
    signal BONUS: std_logic_vector(5 downto 0);
    signal F_POINTS: std_logic_vector(11 downto 0);
    signal U_POINTS: std_logic_vector(11 downto 0);
    signal TESTE: std_logic_vector(3 downto 0);


    component counter_level is
        port(
            DATA: in std_logic_vector(3 downto 0);
            R: in std_logic;
            E: in std_logic;
            clock: in std_logic;
            end_FPGA: out std_logic
        );
    end component;

    component counter_time is
        port(
            R: in std_logic;
            E: in std_logic;
            clock: in std_logic;
            end_time: out std_logic;
            time1: out std_logic_vector(3 downto 0)
        );
    end component;

    component counter_round is
        port(data: in std_logic_vector(3 downto 0);
            SET: in std_logic;
            E: in std_logic;
            clock: in std_logic;
            end_round: out std_logic;
            round1: out std_logic_vector(3 downto 0)
        );
    end component;

    component counter_bonus is
        port(data: in std_logic_vector(5 downto 0);
            DATA2: in std_logic_vector(5 downto 0);
            SET: in std_logic;
            E: in std_logic;
            clock: in std_logic;
            end_bonus: out std_logic;
            BONUS: out std_logic_vector(5 downto 0)
        );
    end component;

    component REG_setup is
        port(
            A: in std_logic_vector(13 downto 0);
            R: in std_logic;
            E: in std_logic;
            clock: in std_logic;
            SETUP: out std_logic_vector(13 downto 0));
    end component;

    component sum is
        port (f: in std_logic_vector(17 downto 0);
        q: out std_logic_vector(5 downto 0)
        );
    end component;

    component SEQ1 is
        port ( address : in std_logic_vector(3 downto 0);
               data : out std_logic_vector(17 downto 0) );
      end component;

    component SEQ2 is
        port ( address : in std_logic_vector(3 downto 0);
               data : out std_logic_vector(17 downto 0) );
    end component;

    component SEQ3 is
        port ( address : in std_logic_vector(3 downto 0);
               data : out std_logic_vector(17 downto 0) );
    end component;

    component SEQ4 is
        port ( address : in std_logic_vector(3 downto 0);
               data : out std_logic_vector(17 downto 0) );
    end component;

    component decBCD is
        port(
            a: in std_logic_vector(3 downto 0);
            b: out std_logic_vector(7 downto 0)
        );
    end component;

    component multiplexador4x1 is
        port (a: in std_logic_vector (17 downto 0);
              b: in std_logic_vector (17 downto 0);
              c: in std_logic_vector (17 downto 0);
              d: in std_logic_vector (17 downto 0);
              e: in std_logic_vector (1 downto 0);
              saida: out std_logic_vector(17 downto 0));
    end component;

    component multiplexador2x1_7 is
        port (a: in std_logic_vector (17 downto 0);
              b: in std_logic_vector (17 downto 0);
              c: in std_logic;
              d: out std_logic_vector(17 downto 0));
    end component;

    component HEX71 is
        port(
            E5: in std_logic;
            E6: in std_logic;
            end_round_aux: in std_logic;
            s: out std_logic_vector(6 downto 0)
        );
    end component;

    component HEX61 is
        port(
            SETUP: in std_logic_vector(3 downto 0);
            E5: in std_logic;
            E6: in std_logic;
            end_round_aux: in std_logic;
            s: out std_logic_vector(6 downto 0)
        );
    end component;

    component HEX51 is
        port(
            E5: in std_logic;
            E6: in std_logic;
            end_round_aux: in std_logic;
            s: out std_logic_vector(6 downto 0)
        );
    end component;

    component HEX41 is
        port(
            SETUP: in std_logic_vector(1 downto 0);
            E5: in std_logic;
            E6: in std_logic;
            end_round_aux: in std_logic;
            s: out std_logic_vector(6 downto 0)
        );
    end component;

    component HEX31 is
        port(
            E5: in std_logic;
            E6: in std_logic;
            end_round_aux: in std_logic;
            s: out std_logic_vector(6 downto 0)
        );
    end component;

    component HEX21 is
        port(
            SETUP: in std_logic_vector(3 downto 0);
            SETUP2: in std_logic_vector(3 downto 0);
            SETUP3: in std_logic_vector(3 downto 0);
            E5: in std_logic;
            E6: in std_logic;
            end_round_aux: in std_logic;
            s: out std_logic_vector(6 downto 0)
        );
    end component;

    component HEX11 is
        port(
            SETUP: in std_logic_vector(3 downto 0);
            SETUP2: in std_logic_vector(3 downto 0);
            SETUP3: in std_logic_vector(3 downto 0);
            E5: in std_logic;
            E6: in std_logic;
            end_round_aux: in std_logic;
            s: out std_logic_vector(6 downto 0)
        );
    end component;

    component HEX01 is
        port(
            SETUP: in std_logic_vector(3 downto 0);
            SETUP2: in std_logic_vector(3 downto 0);
            SETUP3: in std_logic_vector(3 downto 0);
            SETUP4: in std_logic_vector(3 downto 0);
            E5: in std_logic;
            E6: in std_logic;
            end_round_aux: in std_logic;
            s: out std_logic_vector(6 downto 0)
        );
    end component;

    component LEDS is
        port(
            a: in std_logic_vector(17 downto 0);
            b: in std_logic_vector(17 downto 0);
            e2: in std_logic;
            s: out std_logic_vector(17 downto 0)
        );
    end component;

begin

    REG: REG_setup port map(A => sw_entra(13 downto 0),
                            R => r1,
                            E => e1,
                            clock => clk50,
                            SETUP => SETUP);
    X1 <= r1 or e4;
    COL: counter_level port map(DATA => SETUP(9 downto 6),
                                R => X1,
                                E => e2,
                                clock => clk1,
                                end_FPGA => end_FPGA);
    
    COT: counter_time port map(R => X1,
                               E => e3,
                               clock => clk1,
                               end_time => end_time,
                               time1 => time1);
    TESTE <= SETUP(3 downto 0) - "0001";
    COR: counter_round port map(data => TESTE,
                                SET => e1,
                                E => e4,
                                clock => clk50,
                                end_round => end_round1,
                                round1 => round1);
    end_round <= end_round1;
    DE1: decBCD port map(a => round1,
                         b => ROUND_BCD);
    SE1: SEQ1 port map(address => round1,
                        data => S1);
    SE2: SEQ2 port map(address => round1,
                        data => S2);
    SE3: SEQ3 port map(address => round1,
                        data => S3);
    SE4: SEQ4 port map(address => round1,
                        data => S4);
    MULT4: multiplexador4x1 port map(a => S1,
                                     b => S2,
                                     c => S3,
                                     d => S4,
                                     e => SETUP(5 downto 4),
                                     saida => SEQ_FGPA);
    X5 <= SEQ_FGPA xor sw_entra;
    SU1: sum port map(f => X5,
                      q => nao_aguento_mais_signal);
    X2 <= "00" & SETUP(13 downto 10);
    X3 <= e3 and (not key_entra);
    COB: counter_bonus port map(data => nao_aguento_mais_signal,
                                DATA2 => X2,
                                SET => e1,
                                E => X3,
                                clock => clk50,
                                end_bonus => end_bonus,
                                BONUS => BONUS);
    F_POINTS <= "00" & round1 & (not BONUS);
    U_POINTS <= "00" & (not round1) & BONUS;
    LD1: LEDS port map(a => "000000000000000000",
                         b => SEQ_FGPA,
                         e2 => e2,
                         s => X4);
    led_out <= X4;
    HEX70: HEX71 port map(E5 => e5,
                          E6 => e6,
                          end_round_aux => end_round1,
                          s => h7);
    HEX60: HEX61 port map(SETUP => SETUP(9 downto 6),
                          E5 => e5,
                          E6 => e6,
                          end_round_aux => end_round1,
                          s => h6);
    HEX50: HEX51 port map(E5 => e5,
                          E6 => e6,
                          end_round_aux => end_round1,
                          s => h5);
    HEX40: HEX41 port map(SETUP => SETUP(5 downto 4),
                          E5 => e5,
                          E6 => e6,
                          end_round_aux => end_round1,
                          s => h4);
    HEX30: HEX31 port map(E5 => e5,
                          E6 => e6,
                          end_round_aux => end_round1,
                          s => h3);
    HEX20: HEX21 port map(SETUP => time1,
                          SETUP2 => F_POINTS(11 downto 8),
                          SETUP3 => U_POINTS(11 downto 8),
                          E5 => e5,
                          E6 => e6,
                          end_round_aux => end_round1,
                          s => h2);
    HEX10: HEX11 port map(SETUP => ROUND_BCD(7 downto 4),
                          SETUP2 => F_POINTS(7 downto 4),
                          SETUP3 => U_POINTS(7 downto 4),
                          E5 => e5,
                          E6 => e6,
                          end_round_aux => end_round1,
                          s => h1);
    HEX00: HEX01 port map(SETUP => BONUS(3 downto 0),
                          SETUP2 => ROUND_BCD(3 downto 0),
                          SETUP3 => F_POINTS(3 downto 0),
                          SETUP4 => U_POINTS(3 downto 0),
                          E5 => e5,
                          E6 => e6,
                          end_round_aux => end_round1,
                          s => h0);

end arqdata;




