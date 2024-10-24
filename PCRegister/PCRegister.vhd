-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Program Counter (PC) Register

library ieee;
use ieee.std_logic_1164.all;

entity PCRegister is 
	port (Input  : in std_logic_vector (15 downto 0);
			Enable : in std_logic;
			Clock  : in std_logic;
			
			Output : out std_logic_vector (15 downto 0));	
end PCRegister;

architecture func_PCRegister of PCRegister is
begin

	process (Clock)
	begin
	
		if Clock'event and Clock = '0' then
		
			if Enable = '1' then
				Output <= Input;
			end if;
			
		end if;
		
	end process;

end func_PCRegister;