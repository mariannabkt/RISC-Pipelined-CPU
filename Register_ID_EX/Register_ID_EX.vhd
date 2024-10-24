-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Register ID_EX

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_ID_EX is
	port (clock 			: in std_logic;
			isEOR 			: in std_logic;
			wasJumpOut 		: in std_logic;
			isJump			: in std_logic;
			isJR				: in std_logic;
			isBranch			: in std_logic;
			isR				: in std_logic;
			isMFPC			: in std_logic;
			isLW				: in std_logic;
			isSW				: in std_logic;
			isReadDigit		: in std_logic;
			isPrintDigit 	: in std_logic;
			ALUFunc 			: in std_logic_vector (3 downto 0);
			R1Reg 			: in std_logic_vector (15 downto 0);
			R2Reg 			: in std_logic_vector (15 downto 0);
			immediate16 	: in std_logic_vector (15 downto 0);
			R2AD				: in std_logic_vector (2 downto 0);
			R1AD 				: in std_logic_vector (2 downto 0);
			jumpShortAddr 	: in std_logic_vector (11 downto 0);
		
			isEOR_ID_EX				: out std_logic;
			wasJumpOut_ID_EX		: out std_logic;
			isJump_ID_EX			: out std_logic;
			isJR_ID_EX 				: out std_logic;
			isBranch_ID_EX			: out std_logic;
			isR_ID_EX				: out std_logic;
			isMFPC_ID_EX			: out std_logic;
			isLW_ID_EX				: out std_logic;
			isSW_ID_EX				: out std_logic;
			isReadDigit_ID_EX		: out std_logic;
			isPrintDigit_ID_EX 	: out std_logic;
			ALUFunc_ID_EX 			: out std_logic_vector (3 downto 0);
			R1Reg_ID_EX 			: out std_logic_vector (15 downto 0);
			R2Reg_ID_EX 			: out std_logic_vector (15 downto 0);
			immediate16_ID_EX 	: out std_logic_vector (15 downto 0);
			R2AD_ID_EX 				: out std_logic_vector (2 downto 0) ;
			R1AD_ID_EX 				: out std_logic_vector (2 downto 0) ;
			jumpShortAddr_ID_EX 	: out std_logic_vector (11 downto 0));
end Register_ID_EX;

architecture funcRegister_ID_EX of Register_ID_EX is
begin

	pc: process (clock)
	begin
	
		if clock='1' then
			isEOR_ID_EX <= isEOR;
			wasJumpOut_ID_EX <= wasJumpOut;
			isJump_ID_EX <= isJump;
			isJR_ID_EX <= isJR;
			isBranch_ID_EX <= isBranch;
			isR_ID_EX <= isR;
			isMFPC_ID_EX <= isMFPC;
			ALUFunc_ID_EX <= ALUFunc;
			R1Reg_ID_EX <= R1Reg;
			R2Reg_ID_EX <= R2Reg;
			immediate16_ID_EX <= immediate16;
			R2AD_ID_EX <= R2AD;
			R1AD_ID_EX <= R1AD;
			jumpShortAddr_ID_EX <= jumpShortAddr;
			isReadDigit_ID_EX <= isReadDigit;
			isPrintDigit_ID_EX <= isPrintDigit;
			isLW_ID_EX <= isLW;
			isSW_ID_EX <= isSW;
		end if;
		
	end process pc;

end architecture funcRegister_ID_EX;
