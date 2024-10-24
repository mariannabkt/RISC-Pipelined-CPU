-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- Forwarder

library ieee;
use ieee.std_logic_1164.all;

entity forwarder is
	port (regRS_address		: in std_logic_vector (2 downto 0); 
			regRT_address		: in std_logic_vector (2 downto 0); 
			regRD_EX_address 	: in std_logic_vector (2 downto 0);
			regRD_MEM_address : in std_logic_vector (2 downto 0);
			
			ForwardA				: out std_logic_vector (1 downto 0);
			ForwardB 			: out std_logic_vector (1 downto 0));
end forwarder;

architecture func_forwarder of forwarder is
begin

    process (regRS_address, regRT_address, regRD_EX_address, regRD_MEM_address)
    begin

    ForwardA <= "00";
    ForwardB <= "00";

        if regRS_address = regRD_EX_address then
            ForwardA(1) <= '1'; 
        elsif regRS_address = regRD_MEM_address then
            ForwardA(0) <= '1'; 
        else
            ForwardA <= "00"; 
        end if;
        

        if regRT_address = regRD_EX_address then
            ForwardB(1) <= '1'; 
        elsif regRT_address = regRD_MEM_address then
            ForwardB(0) <= '1'; 
        else
            ForwardB <= "00"; 
        end if;
		  
    end process;

end func_forwarder;