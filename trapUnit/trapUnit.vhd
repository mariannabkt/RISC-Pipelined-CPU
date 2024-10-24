-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Trap Unit

library ieee;
use ieee.std_logic_1164.all;

entity trapUnit is
	port (opCode 		 : in std_logic_vector (3 downto 0);
			
			endOfRunning : out std_logic);
end trapUnit;

architecture func_trapUnit of trapUnit is
begin

	pc: process (opCode)
	begin
	
		if opCode="1110" then	
			endOfRunning <= '1';
		else
			endOfRunning <= '0';
		end if;
		
	end process pc;


end func_trapUnit;