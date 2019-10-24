library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity edice_fsm is
    port (
            clk: in std_logic;
            result_select: in std_logic_vector(2 downto 0);
            cheat_mode: in std_logic_vector(1 downto 0);
            rst: in std_logic;
            run: in std_logic;
            --cout: out std_logic_vector(2 downto 0);
            seven_seg: out std_logic_vector(6 downto 0);
            led_out: out std_logic_vector(6 downto 0);
            Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0)-- 4 Anode signals
        );

end edice_fsm;


architecture edice_fsm_arch of edice_fsm is
--constant PRESCALER_constant: unsigned(25 downto 0) := "01111101110111110000100010";
--signal PRESCALER: unsigned(25 downto 0) := (others => '0') ;
type seq_state_type is ( s0, s1, s2, s3, s4, s5, s6, s7,s8);
signal state_reg, state_next: seq_state_type;
signal cheat_valid: std_logic;
signal cheat_mode_buff:std_logic_vector (1 downto 0);
signal result_select_buff: std_logic_vector (2 downto 0);
signal cout_buff : std_logic_vector(2 downto 0);
begin

decoder: entity work.decoder_7seg_led port map(value => cout_buff, seven_seg=>seven_seg, led_out=>led_out);
-- state register section


process (rst,clk)
begin
    if (rst = '1') then
        state_reg <= s0;
    elsif ( rising_edge(clk) ) then
           state_reg <= state_next;
--         if PRESCALER < PRESCALER_CONSTANT then
--                    PRESCALER <= PRESCALER + 1;
--            else
--                    PRESCALER <= (others => '0');
    
--                    state_reg <= state_next;
    
--          end if;

    end if;

end process;

--- end state register section

-- buffer the cheat mode and result select in registers for next run
--process (rst,clk,run)
--begin
--    if (rst = '1') then
--        cheat_mode_buff <= "00";
--    elsif ( rising_edge(clk) ) then
--        if (run = '1') then
--            cheat_mode_buff <= cheat_mode;
--        end if;
--    end if;
--
--end process;

cheat_mode_buff <= cheat_mode;
--process (rst,clk,run)
--begin
--    if (rst = '1') then
--        result_select_buff <= "000";
--    elsif ( rising_edge(clk) ) then
--        if (run = '1') then
--            result_select_buff <= result_select;
--        end if;
--    end if;
--
--end process;


result_select_buff <= result_select;

cheat_valid <= '0' when result_select_buff = "111" or result_select_buff = "000" else
               '1';

Anode_Activate <= "0111"; 
--- fsm next state section

process (state_reg,run,cheat_valid,cheat_mode_buff)
begin
    case state_reg is 
        when s0 =>
            if (run = '1' ) then
                    state_next <= s1;
            elsif ( cheat_mode_buff = "10" and cheat_valid = '1') then
                    state_next <= s8;
            else
                    state_next <= s0;
            end if;
        when s1 =>
            if (run = '1' ) then
                    state_next <= s2;
            elsif ( cheat_mode_buff = "10" and cheat_valid = '1') then
                    state_next <= s8;
            else
                    state_next <= s1;
            end if;
        when s2 =>
            if (run = '1' ) then
                    state_next <= s3;
            elsif ( cheat_mode_buff = "10" and cheat_valid = '1') then
                    state_next <= s8;
            else
                    state_next <= s2;
            end if;
        when s3 =>
            if (run = '1' ) then
                    state_next <= s4;
            elsif ( cheat_mode_buff = "10" and cheat_valid = '1') then
                    state_next <= s8;
            else
                    state_next <= s3;
            end if;
        when s4 =>
            if (run = '1' ) then
                    state_next <= s5;
            elsif ( cheat_mode_buff = "10" and cheat_valid = '1') then
                    state_next <= s8;
            else
                    state_next <= s4;
            end if;
        when s5 =>
            if (run = '1' ) then
                if (cheat_valid = '1' and cheat_mode_buff = "11") then
                    state_next <= s6;
                else
                    state_next <= s0;
                end if;
            elsif ( cheat_mode_buff = "10" and cheat_valid = '1') then
                    state_next <= s8;
            else
                    state_next <= s5;
            end if;
        when s6 =>
            if (run = '1' ) then
                    state_next <= s7;
            else
                    state_next <= s6;
            end if;
        when s7 =>
            if (run = '1' ) then
                    state_next <= s0;
            else
                    state_next <= s7;
            end if;
        when s8 =>
            if (run = '1' ) then
                    state_next <= s0;
            else
                    state_next <= s8;
            end if;
    end case;

end process;


--- end fsm next state section



--- output section





process(run,state_reg,result_select_buff,cheat_mode_buff)
begin
    case state_reg is 
        when s0 =>
            if (run = '1' ) then
                cout_buff <= "000";
            elsif ( cheat_mode_buff = "01" and cheat_valid = '1' and result_select_buff = "001" ) then
                cout_buff <= "001"; 
            else
                cout_buff <= "000";
            end if;
        when s1 =>
            if (run = '1' ) then
                cout_buff <= "001";
            elsif ( cheat_mode_buff = "01" and cheat_valid = '1' and result_select_buff = "010" ) then
                cout_buff <= "010"; 
            else
                cout_buff <= "001";
            end if;
        when s2 =>
            if (run = '1' ) then
                cout_buff <= "010";
            elsif ( cheat_mode_buff = "01" and cheat_valid = '1' and result_select_buff = "011" ) then
                cout_buff <= "011"; 
            else
                cout_buff <= "010";
            end if;
        when s3 =>
            if (run = '1' ) then
                cout_buff <= "011";
            elsif ( cheat_mode_buff = "01" and cheat_valid = '1' and result_select_buff = "100" ) then
                cout_buff <= "100"; 
            else
                cout_buff <= "011";
            end if;
        when s4 =>
            if (run = '1' ) then
                cout_buff <= "100";
            elsif ( cheat_mode_buff = "01" and cheat_valid = '1' and result_select_buff = "101" ) then
                cout_buff <= "101"; 
            else
                cout_buff <= "100";
            end if;
        when s5 =>
            if (run = '1' ) then
                cout_buff <= "101";
            elsif ( cheat_mode_buff = "01" and cheat_valid = '1' and result_select_buff = "110" ) then
                cout_buff <= "000"; 
            else
                cout_buff <= "101";
            end if;
        when s6 | s7 | s8 =>
                cout_buff <= std_logic_vector( unsigned(result_select_buff) - 1);
    end case;
end process;



--- output section
end edice_fsm_arch; 
