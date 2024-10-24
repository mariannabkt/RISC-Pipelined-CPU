-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Selector 

library ieee;
use ieee.std_logic_1164.all;

entity Selector is
	port (regAddress	: in std_logic_vector (15 downto 0);
			regAD_MEM 	: in std_logic_vector (15 downto 0);
			regAD_WB		: in std_logic_vector (15 downto 0);
			operation 	: in std_logic_vector (1 downto 0);
			
			Output 		: out std_logic_vector (15 downto 0));
end Selector;

architecture funcSelector of Selector is
begin

    process (regAddress, regAD_MEM, regAD_WB, operation)
    begin
	 
        case operation is
            when "10" =>
                Output <= regAD_MEM;
            when "01" =>
                Output <= regAD_WB;
            when "00" =>
                Output <= regAddress;
            when others =>
                Output <= (others => '0');
        end case;
		  
    end process;
					
end funcSelector;