library ieee;
use ieee.std_logic_1164.all;

entity controlador is port (
clock,reset,enter, end_fpga, end_bonus, end_time, end_round: in std_logic;
r1, e1, e2, e3, e4, e5, e6: out std_logic );
end controlador;

architecture fsmcontrolador of controlador is
    type STATES is (start, setup, play_fpga, play_user, check, result, next_round, wait1);
    signal EAtual, PEstado: STATES;
begin
    process(clock,reset)
    begin
        if (reset = '0') then
            EAtual <= start;
        elsif (clock'event AND clock = '1') then 
             EAtual <= PEstado;
        end if;
    end process;

    process(EAtual, enter, end_fpga, end_bonus, end_time, end_round)
    begin
        case EAtual is
            when start => 
                r1 <= '1';
                e1 <= '0';
                e2 <= '0';
                e3 <= '0';
                e4 <= '0';
                e5 <= '0'; --//seleciona a entrada do mux em qual dos valores armazenados passam
                e6 <= '0';
                PEstado <= setup;

            when setup =>
                r1 <= '0';
                e1 <= '1'; --//habilita o registrador para que selecionemos as configuraçoes de jogo descrita no pdf no estado setup
                e2 <= '0';
                e3 <= '0';
                e4 <= '0';
                e5 <= '0';
                e6 <= '0';
                if (enter = '0') then
                    PEstado <= play_fpga;
                elsif (enter = '1') then
                    PEstado <= setup;
                end if;

            when play_fpga =>
                r1 <= '0'; --//mantem o reset em 0 pois nao ha necessidade de resetar
                e1 <= '0'; --//da um set no counter round
                e2 <= '1'; --//habilita o counter level que possui entrada data que vai contar de 0 ate o valor inserido no estado setup
                e3 <= '0';
                e4 <= '0'; --//habilita o counter round que inicia no valor maximo com a entrada de 1 setando para maximo e decrementando 1 ate chegar a zero seleciona a sequencia que iremos usar nos leds
                e5 <= '0';
                e6 <= '0';
                if (end_fpga = '1') then
                    PEstado <= play_user;
                else
                    Pestado <= play_fpga;
                end if;
            
            when play_user =>
                r1 <= '0';
                e1 <= '0';
                e2 <= '0';
                e3 <= '1';
                e4 <= '0';
                e5 <= '0';
                e6 <= '0';
                if (end_time = '1') or (end_bonus = '1') then
                    PEstado <= result;
                elsif (enter = '0') then
                    Pestado <= check;
                else
                    PEstado <= play_user;
                end if;
            
            when check =>
                r1 <= '0';
                e1 <= '0';
                e2 <= '0';
                e3 <= '1';
                e4 <= '0';
                e5 <= '0';
                e6 <= '0';
                if (end_bonus = '1') or (end_round = '1') then
                    PEstado <= result;
                else
                    PEstado <= next_round;
                end if;

            when result =>
                r1 <= '0';
                e1 <= '0';
                e2 <= '0';
                e3 <= '0';
                e4 <= '0';
                e5 <= '0';
                e6 <= '1';
                if (enter = '0') then
                    PEstado <= start;
                else
                    PEstado <= result;
                end if;

            when next_round => 
                r1 <= '0';
                e1 <= '0';
                e2 <= '0';
                e3 <= '0';
                e4 <= '1';
                e5 <= '0';
                e6 <= '0';
                PEstado <= wait1;

            when wait1 =>
                r1 <= '0';
                e1 <= '0';
                e2 <= '0';
                e3 <= '0';
                e4 <= '0';
                e5 <= '1';
                e6 <= '0';
                if (enter = '0') then
                    PEstado <= play_fpga;
                else
                    Pestado <= wait1;
                end if;            
        end case;
    end process;
end fsmcontrolador;