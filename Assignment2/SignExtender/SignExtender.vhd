-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Immediate Extension

library ieee;
use ieee.std_logic_1164.all;
 
entity SignExtender is
	port (immediate: in std_logic_vector(5 downto 0); 
			extended: out std_logic_vector(15 downto 0));
end SignExtender;
 
architecture STRUCTURE_SignExtender of SignExtender is
begin
	
	extended <= (15 downto 6 => immediate(5)) & immediate;
	
end STRUCTURE_SignExtender;