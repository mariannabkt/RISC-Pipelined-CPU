-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- NAND GATE for Flip-Flop named reg

library ieee;
use ieee.std_logic_1164.all;

entity NAND_GATE is
	port (in1, in2: in std_logic;
			out1: out std_logic); 
end NAND_GATE;

architecture STRUCTURE_NAND_GATE of NAND_GATE is

	component AND_GATE
		port (in1,in2: in std_logic; 
				out1: out std_logic);
	end component;
	
	component NOT_GATE
		port (in1: in std_logic;
				out1: out std_logic);
	end component;
	
	signal temp : std_logic;

begin
	
	U0: AND_GATE port map (in1, in2, temp);
	U1: NOT_GATE port map (temp, out1);

end STRUCTURE_NAND_GATE;


-- 1-bit Flip Flop

library ieee;
use ieee.std_logic_1164.all;

entity reg_Slice is
	port (clock, enable, input: in std_logic;
			output: out std_logic); 
end reg_Slice;

architecture STRUCTURE_regSlice of reg_Slice is

	component NAND_GATE
		port (in1,in2: in std_logic; 
				out1: out std_logic);
	end component;

	component AND_GATE
		port (in1,in2: in std_logic; 
				out1: out std_logic);
	end component;
	
	component NOT_GATE
		port (in1: in std_logic;
				out1: out std_logic);
	end component;
	
	signal afterClock, p1, p2, p3, p4, p5, p6, temp1, temp2 : std_logic;

begin

	U0: NAND_GATE port map (p1, p4, p3); -- 1
	
	U1: NAND_GATE port map (p3, afterclock, p1); -- 2
	
	U2: AND_GATE port map (p1, p4, temp1); -- 3
	
	U3: AND_GATE port map (afterClock, temp1, temp2); -- 3
	
	U4: NOT_GATE port map (temp2, p2); -- 3
	
	U5: NAND_GATE port map (input, p2, p4); -- 4
	
	U6: NAND_GATE port map (p6, p1, p5); -- 5
	
	U7: NAND_GATE port map (p2, p5, p6); -- 6
	
	U8: AND_GATE port map (clock, enable, afterClock); -- AfterClock
	
	U9: AND_GATE port map (p5, p5, output);

end STRUCTURE_regSlice;