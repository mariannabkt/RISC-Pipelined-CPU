-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- 16-bit Flip Flop named reg0 that ouputs only 0s

library ieee;
use ieee.std_logic_1164.all;

entity reg0 is
	generic (size : INTEGER := 15);
	port (clock, enable: in std_logic;
			input:  in  std_logic_vector (size downto 0);
			output: out std_logic_vector (size downto 0)); 
end reg0;

architecture STRUCTURE_reg0 of reg0 is

begin
	
	output <= (others => '0');
	
end STRUCTURE_reg0;