-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- 16-bit Flip Flop named reg

library ieee;
use ieee.std_logic_1164.all;

entity reg16bit is
	port (clock, enable: in std_logic;
			input:  in  std_logic_vector (15 downto 0);
			output: out std_logic_vector (15 downto 0)); 
end reg16bit;

architecture STRUCTURE_reg16bit of reg16bit is

	component reg_Slice
		port (clock, enable, input: in std_logic;
				output: out std_logic);
	end component;

begin

	GEN_REG: for i in 0 to 15 generate
		 REG: reg_Slice port map(clock, enable, input(i), output(i));
	end generate;
	
end STRUCTURE_reg16bit;