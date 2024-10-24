-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Control Unit

library ieee;
use ieee.std_logic_1164.all;

entity controller is
	port (IF_ID_Flush : in std_logic;
			OpCode      : in std_logic_vector (3 downto 0);
			func        : in std_logic_vector (2 downto 0);

			isRType     : out std_logic;
			isBranch    : out std_logic;
			isJReg      : out std_logic;
			isJType     : out std_logic;
			isLdWord    : out std_logic;
			isStWord    : out std_logic;
			isMPFC      : out std_logic;
			isReadDig   : out std_logic;
			isWriteDig  : out std_logic);
end controller;

architecture func_controller of controller is
begin

	process(IF_ID_Flush, OpCode, func)
	begin
	
		-- comment this section for rtl
		isRType     <= '0';
		isMPFC      <= '0';
		isLdWord    <= '0';
		isStWord    <= '0';
		isBranch    <= '0';
		isReadDig   <= '0';
		isWriteDig  <= '0';
		isJReg      <= '0';
		isJType     <= '0';

		if IF_ID_Flush = '1' then
			isRType     <= '0';
			isMPFC      <= '0';
			isLdWord    <= '0';
			isStWord    <= '0';
			isBranch    <= '0';
			isReadDig   <= '0';
			isWriteDig  <= '0';
			isJReg      <= '0';
			isJType     <= '0';
		else
			if OpCode = "0000" then
				isRType <= '1';
				if func = "111" then
					isMPFC <= '1';
				end if;
			elsif OpCode = "0001" then
				isLdWord <= '1';
			elsif OpCode = "0010" then
				isStWord <= '1';
			elsif OpCode = "0100" then
				isBranch <= '1';
			elsif OpCode = "0110" then
				isReadDig <= '1';
			elsif OpCode = "0111" then
				isWriteDig <= '1';
			elsif OpCode = "1101" then
				isJReg <= '1';
			elsif OpCode = "1111" then
				isJType <= '1';
			end if;
		end if;

	end process;

end func_controller;