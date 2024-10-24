-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Register IF_ID

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_IF_ID is
	port (IF_Flush 		: in std_logic;
			IF_ID_Enable 	: in std_logic;
			clock 			: in std_logic;
			PCin 				: in std_logic_vector (15 downto 0);
			Command 			: in std_logic_vector (15 downto 0);
			
			PCout 			: out std_logic_vector (15 downto 0);
			Commandout 		: out std_logic_vector (15 downto 0));
end Register_IF_ID;


architecture funcRegister_IF_ID of Register_IF_ID is
begin

	pc: process (clock, IF_Flush, IF_ID_Enable, PCin, Command)		
	begin
		
		if (clock = '1' and IF_ID_Enable = '1') then
	
			PCout <= std_logic_vector(unsigned(PCin) + 2);
			Commandout <= Command;
		
		elsif (clock = '1' and IF_Flush = '1') then
	
			PCout <= (OTHERS => '0');
			Commandout <= (OTHERS => '0');
		
		end if;
	
	end process pc;

end architecture funcRegister_IF_ID;