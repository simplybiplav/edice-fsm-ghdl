
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_7seg_led is
    port (
            value: in std_logic_vector(2 downto 0);
            seven_seg: out std_logic_vector(6 downto 0);
            led_out: out std_logic_vector(6 downto 0)
        );
end decoder_7seg_led;


architecture decoder_7seg_led_arch of decoder_7seg_led is
begin
with value select
        seven_seg <= "1001111" when "000" ,
                     "0010010" when "001" ,
                     "0000110" when "010" ,
                     "1001100" when "011" ,
                     "0100100" when "100" ,
                     "0100000" when "101" ,
                     "1111110" when others;

with value select
        led_out <=   "0001000" when "000" ,
                     "0010100" when "001" ,
                     "0011100" when "010" ,
                     "1010101" when "011" ,
                     "1011101" when "100" ,
                     "1110111" when "101" ,
                     "0000000" when others;

end decoder_7seg_led_arch;
