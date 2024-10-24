-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- ALU Control

library ieee;
use ieee.std_logic_1164.all;
 
entity alu_control is
	port (opcode: in std_logic_vector(3 downto 0);
			func: in std_logic_vector(2 downto 0);
			ALUoperation: out std_logic_vector(3 downto 0));
end alu_control;
 
architecture STRUCTURE_alu_control of alu_control is
begin

	process (opcode, func) begin
		case opcode is
			when "0000" =>
				ALUoperation(3) <= '0';
				ALUoperation(2 downto 0) <= func(2 downto 0);
			when others => ALUoperation <= opcode;
		end case;
	end process;
	
end STRUCTURE_alu_control;