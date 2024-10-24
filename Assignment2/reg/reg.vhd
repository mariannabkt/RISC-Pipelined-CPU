-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- 16-bit Flip Flop named reg

library ieee;
use ieee.std_logic_1164.all;

entity reg is
	generic (size : INTEGER := 15);
	port (clock, enable: in std_logic;
			input:  in  std_logic_vector (size downto 0);
			output: out std_logic_vector (size downto 0)); 
end reg;

architecture STRUCTURE_reg of reg is

	component reg_Slice
		port (clock, enable, input: in std_logic;
				output: out std_logic);
	end component;

begin

	GEN_REG: for i in 0 to size generate
		 REG: reg_Slice port map(clock, enable, input(i), output(i));
	end generate;
	
end STRUCTURE_reg;