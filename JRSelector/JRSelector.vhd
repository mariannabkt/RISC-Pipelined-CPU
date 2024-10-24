-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- JRSelector

library ieee;
use ieee.std_logic_1164.all;

entity JRSelector is
	port( jumpAD		: in std_logic_vector (15 downto 0); 
			branchAd		: in std_logic_vector (15 downto 0); 
			PCP2AD 		: in std_logic_vector (15 downto 0);
			JRopcode 	: in std_logic_vector (1 downto 0);
			
			result 		: out std_logic_vector (15 downto 0));
end JRSelector;

architecture func_JRSelector of JRSelector is
begin

	process (JRopcode, PCP2AD, jumpAD, branchAd)
	begin

		case JRopcode is
			when "01" => result <= jumpAD;
			when "10" => result <= branchAd;
			when others => result <= PCP2AD;
		end case;
	
	end process;

end func_JRSelector;