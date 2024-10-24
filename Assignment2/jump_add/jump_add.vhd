-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- JumpAddress Calculation

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity jump_add is
	port (jumpAD: in std_logic_vector(11 downto 0); 
			instrP2AD: in std_logic_vector(15 downto 0);
			EjumpAD: out std_logic_vector(15 downto 0));
end jump_add;
 
architecture STRUCTURE_jump_add of jump_add is

	signal extended, temp: std_logic_vector(15 downto 0);

begin
	
	extended <= (15 downto 12 => jumpAD(11)) & jumpAD;

	process (instrP2AD)
	begin
		temp <= std_logic_vector(unsigned(extended) sll 1);
		EjumpAD <= std_logic_vector(unsigned (temp) + unsigned(instrP2AD));
	end process;
	
end STRUCTURE_jump_add;