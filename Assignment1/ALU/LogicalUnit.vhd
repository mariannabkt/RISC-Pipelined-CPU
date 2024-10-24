-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- Logical Unit

-- 2 input AND gate
library ieee;
use ieee.std_logic_1164.all;

entity AND_GATE is
	port(in1, in2 : in std_logic;
		  out1 : out std_logic);
end AND_GATE;

architecture STRUCTURE_AND of AND_GATE is
begin
	out1 <= in1 AND in2;
end STRUCTURE_AND;


-- 2 input OR gate
library ieee;
use ieee.std_logic_1164.all;

entity OR_GATE is
	port(in1, in2 : in std_logic;
		  out1 : out std_logic);
end OR_GATE;

architecture STRUCTURE_OR of OR_GATE is
begin
	out1 <= in1 OR in2;
end STRUCTURE_OR;


-- 2 input XOR gate
library ieee;
use ieee.std_logic_1164.all;

entity XOR_GATE is
	port(in1, in2 : in std_logic;
		  out1 : out std_logic);
end XOR_GATE;

architecture STUCTURE_XOR of XOR_GATE is

	component AND_GATE
		port (in1, in2: in std_logic;
				out1: out std_logic);
	end component;
	
	component OR_GATE
		port (in1, in2: in std_logic;
				out1: out std_logic);
	end component;
	
	component NOT_GATE
		port (in1: in std_logic;
				out1: out std_logic);
	end component;
	
	signal NOT_in1, NOT_in2, AND1, AND2 : std_logic;
	
begin
	
	V0: NOT_GATE port map (in1, NOT_in1);
	V1: NOT_GATE port map (in2, NOT_in2);

	V2: AND_GATE port map (in1, NOT_in2, AND1);
	V3: AND_GATE port map (in2, NOT_in1, AND2);

	V4: OR_GATE  port map (AND1, AND2, out1);

end STUCTURE_XOR;



-- ΧΡΗΣΗ ΤΟΥ ΩΣ COMPONENT ΓΙΑ ΑΛΛΑ GATES
-- 1 input NOT gate
library ieee;
use ieee.std_logic_1164.all;

entity NOT_GATE is
	port(in1 : in std_logic;
		  out1 : out std_logic);
end NOT_GATE;

architecture STUCTURE_NOT of NOT_GATE is
begin
	out1 <= NOT in1;
end STUCTURE_NOT;


