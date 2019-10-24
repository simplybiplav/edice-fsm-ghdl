library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity edice_fsm_tb is
end edice_fsm_tb;


architecture edice_fsm_tb_arch of edice_fsm_tb is

constant CLK_PERIOD: time :=10 ns;

signal  clk:  std_logic;
signal  result_select:  std_logic_vector(2 downto 0);
signal  cheat_mode:  std_logic_vector(1 downto 0);
signal  rst:  std_logic;
signal  run:  std_logic;
signal led_out: std_logic_vector(6 downto 0);
--signal  cout:  std_logic_vector(2 downto 0);
begin

-- edice_component: entity work.edice_fsm(edice_fsm_arch) port map ( clk=>clk, rst=>rst,run=>run, cout=>cout,result_select=>result_select,cheat_mode=>cheat_mode);
edice_component: entity work.edice_fsm(edice_fsm_arch) port map ( clk=>clk, rst=>rst,run=>run,result_select=>result_select,cheat_mode=>cheat_mode,led_out=>led_out);

clock: process
begin
    clk <= '0' ;
    wait for CLK_PERIOD/2;
    clk <= '1' ;
    wait for CLK_PERIOD/2;
end process;


io_test: process
begin
    rst <= '0';
    result_select <= "000";
    cheat_mode <= "00";
    run <= '0';
    rst <= '1';
    wait until falling_edge(clk);
    rst <= '0';
    
    run <= '1';
    wait for CLK_PERIOD  * 10;
    run <= '0';
    wait for CLK_PERIOD*4;

    result_select <= "101";
    cheat_mode <= "01";

        
    run <= '1';
    wait for CLK_PERIOD  * 6;
    run <= '0';
    wait for CLK_PERIOD*4;


    result_select <= "011";
    cheat_mode <= "11";
    
    run <= '1';
    wait for CLK_PERIOD  * 10;
    run <= '0';
    wait for CLK_PERIOD*4;


    result_select <= "110";
    cheat_mode <= "10";

        
    run <= '1';
    wait for CLK_PERIOD  * 10;
    run <= '0';
    wait for CLK_PERIOD*4;

    
    result_select <= "000";
    cheat_mode <= "01";

        
    run <= '1';
    wait for CLK_PERIOD  * 10;
    run <= '0';
    wait for CLK_PERIOD*4;


    result_select <= "000";
    cheat_mode <= "11";

        
    run <= '1';
    wait for CLK_PERIOD  * 10;
    run <= '0';
    wait for CLK_PERIOD*4;


    result_select <= "000";
    cheat_mode <= "10";

        
    run <= '1';
    wait for CLK_PERIOD  * 10;
    run <= '0';
    wait for CLK_PERIOD*4;

    result_select <= "111";
    cheat_mode <= "01";

        
    run <= '1';
    wait for CLK_PERIOD  * 10;
    run <= '0';
    wait for CLK_PERIOD*4;


    result_select <= "111";
    cheat_mode <= "11";

        
    run <= '1';
    wait for CLK_PERIOD  * 10;
    run <= '0';
    wait for CLK_PERIOD*4;


    result_select <= "111";
    cheat_mode <= "10";

        
    run <= '1';
    wait for CLK_PERIOD  * 10;
    run <= '0';
    wait for CLK_PERIOD*4;
end process;

end;
