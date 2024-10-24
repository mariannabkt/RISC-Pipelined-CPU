-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- Arithmetic Unit

-- 3 input 1-bit Full Adder
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity FullAdder is
	port (carryin, input1, input2: in std_logic;
			sum, carryout: out std_logic);
end FullAdder;

architecture STRUCTURE_FullAdder of FullAdder is 

	component AND_GATE
		port (in1, in2: in std_logic;
				out1: out std_logic);
	end component;

	component OR_GATE
		port (in1, in2: in std_logic;
				out1: out std_logic);
	end component;

	component XOR_GATE
		port (in1, in2: in std_logic;
				out1: out std_logic);
	end component;
		
	signal s1, s2, s3: std_logic;
	
begin
	-- Half adder 1
	V0: XOR_GATE port map (input1, input2, s1);
	V1: AND_GATE port map (input1, input2, s2);
	
	-- Half adder 2
	V2: XOR_GATE port map (s1, carryin, sum);
	V3: AND_GATE port map (s1, carryin, s3);
	
	V4: OR_GATE  port map (s2, s3, carryout);
	
end STRUCTURE_FullAdder;
