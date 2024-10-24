-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- 8 input MUX

library ieee;
use ieee.std_logic_1164.all;
 
entity MUX8to1 is
	generic (size : INTEGER := 15);
	port (in1, in2, in3, in4, in5, in6, in7, in8: in std_logic_vector(size downto 0); 
			choice: in std_logic_vector(2 downto 0);
			output: out std_logic_vector(size downto 0));
end MUX8to1;
 
architecture STRUCTURE_MUX8to1 of MUX8to1 is

begin

	with choice select
	output<= in1 when "000",
				in2 when "001",
				in3 when "010",
				in4 when "011",
				in5 when "100",
				in6 when "101",
				in7 when "110",
				in8 when "111",
				"0000000000000000" when others;
	
end STRUCTURE_MUX8to1;