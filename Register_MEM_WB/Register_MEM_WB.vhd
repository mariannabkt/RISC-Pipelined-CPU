-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Register MEM_WB

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_MEM_WB is
	port (clock 			: in std_logic;
			regAddress 		: in std_logic_vector (2 downto 0);
			Result 			: in std_logic_vector (15 downto 0);
			
			writeAddress 	: out std_logic_vector (2 downto 0);
			writeData 		: out std_logic_vector (15 downto 0));
end Register_MEM_WB;

architecture funcRegister_MEM_WB of Register_MEM_WB is
begin

	pc: process (Clock)
	begin
	
		if Clock='1' then	
			writeData <= Result;
			writeAddress <= regAddress;
		end if;
		
	end process pc;

end architecture funcRegister_MEM_WB;

