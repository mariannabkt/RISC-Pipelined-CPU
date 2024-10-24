-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- 3 input Decoder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity Decoder3to8 is
	port (input: in std_logic_vector(2 downto 0);
			output: out std_logic_vector(7 downto 0));
end Decoder3to8;
 
architecture STRUCTURE_Decoder3to8 of Decoder3to8 is

begin

	with input select
	output<= "00000001" when "000",
				"00000010" when "001",
				"00000100" when "010",
				"00001000" when "011",
				"00010000" when "100",
				"00100000" when "101",
				"01000000" when "110",
				"10000000" when "111",
				"00000000" when others;
	
end STRUCTURE_Decoder3to8;