-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Hazard Detection Unit

library ieee;
use ieee.std_logic_1164.all;

entity hazardUnit is
	port (isJR			: in std_logic;
			isJump		: in std_logic; 
			wasJump 		: in std_logic;
			shouldBranch: in std_logic;
			
			IF_ID_Flush	: out std_logic;
			wasJumpOut 	: out std_logic;
			JROpCode 	: out std_logic_vector (1 downto 0));
end hazardUnit;

architecture func_hazardUnit of hazardUnit is
begin

	process(isJR, isJump, wasJump, shouldBranch)
	begin
	
		IF_ID_Flush <= '0';
		wasJumpOut <= '0';
		JROpCode <= "00";

		if isJR = '1'  or isJump = '1' or wasJump = '1' or shouldBranch = '1' then
			IF_ID_Flush <= '1';
		end if;
		
		if isJump = '1' then
			JROpCode <= "01";
		elsif shouldBranch = '1' then
			JROpCode <= "10"; 
		else
			JROpCode <= "00";
		end if;
		
		wasJumpOut <= isJump;

	end process;

end func_hazardUnit;
