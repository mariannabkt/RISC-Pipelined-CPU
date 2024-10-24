-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Register EX_MEM

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_EX_MEM is
	port (clock			 : in std_logic;
			isLW			 : in std_logic;
			WriteEnable	 : in std_logic;
			ReadDigit	 : in std_logic;
			PrintDigit	 : in std_logic;
			R2Reg			 : in std_logic_vector (15 downto 0);
			Result		 : in std_logic_vector (15 downto 0);
			RegAD			 : in std_logic_vector (2 downto 0);

			isLW_EX_MEM				: out std_logic;
			WriteEnable_EX_MEM	: out std_logic;
			ReadDigit_EX_MEM		: out std_logic;
			PrintDigit_EX_MEM 	: out std_logic;
			R2Reg_EX_MEM 			: out std_logic_vector (15 downto 0);
			Result_EX_MEM 			: out std_logic_vector (15 downto 0);
			RegAD_EX_MEM 			: out std_logic_vector (2 downto 0));
end Register_EX_MEM;

architecture funcRegister_EX_MEM of Register_EX_MEM is
begin

	pc: process (clock)
	begin
	
		if clock='1' then
			RegAD_EX_MEM <= RegAD;
			R2Reg_EX_MEM <= R2Reg;
			Result_EX_MEM <= Result;
			isLW_EX_MEM <= isLW;
			WriteEnable_EX_MEM <= WriteEnable;
			ReadDigit_EX_MEM <= ReadDigit;
			PrintDigit_EX_MEM <= PrintDigit;
		end if;
		
	end process pc;

end architecture funcRegister_EX_MEM;
