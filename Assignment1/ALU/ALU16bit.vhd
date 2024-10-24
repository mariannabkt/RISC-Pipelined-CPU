-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- opcode input MUX to choose ALU result or GEQ-NOT
library ieee;
use ieee.std_logic_1164.all;
 
entity opcode_MUX is
	port (opcode: in std_logic_vector (2 downto 0); 
			outN: out std_logic);
end opcode_MUX;
 
architecture STRUCTURE_opcode_MUX of opcode_MUX is
begin
	process (opcode)
	begin
		if (opcode = "100" or opcode = "101") then
			outN <= '0';
		else
			outN <= '1';
		end if;
	end process;
end STRUCTURE_opcode_MUX;



-- comparator for GEQ and NOT
library ieee;
use ieee.std_logic_1164.all;
 
entity comp_geq_not is
	port (opcode: in std_logic_vector (2 downto 0); 
			input: in std_logic_vector (15 downto 0);
			output: out std_logic_vector (15 downto 0));
end comp_geq_not;
 
architecture STRUCTURE_comp_geq_not of comp_geq_not is
begin
	process (opcode, input)
	begin
		if (opcode = "100") then
		
			output <= (0 => NOT input(15), others => '0');
			
		elsif (opcode = "101") then
		
			if (input = (15 downto 0 => '0')) then
				output <= (0 => NOT input(0), others => '0');
			else
				output <= (others => '0');
			end if;
			
		end if;
	end process;
end STRUCTURE_comp_geq_not;


-- MUX for final result
library ieee;
use ieee.std_logic_1164.all;

entity result_MUX is
	port (op_bit, ALU_overflow : in std_logic;
			res_ALU, res_Comp: in std_logic_vector (15 downto 0);
			output: out std_logic_vector (15 downto 0);
			carryout: out std_logic);
end result_MUX;


architecture STRUCTURE_result_MUX of result_MUX is
begin
	process (op_bit, res_ALU, res_Comp, ALU_overflow)
	begin
		if (op_bit = '1') then
			output <= res_ALU;
			carryout <= ALU_overflow;
		else
			output <= res_Comp;
			carryout <= '0';
		end if;
	end process;
end STRUCTURE_result_MUX;


-- 16-bit ALU
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ALU16bit is
	port (in1, in2 : in std_logic_vector (15 downto 0);
			opcod   	: in std_logic_vector (3 downto 0);
			res   	: out std_logic_vector (15 downto 0);
			carryout : out std_logic);
end ALU16bit;

architecture STRUCTURE_ALU of ALU16bit is
       
	component ALU_Slice_Type1
		port (a, b : in std_logic;
				opcode : in std_logic_vector (2 downto 0);
				result, carryout: out std_logic);
	end component;
	
	component ALU_Slice_Type2
		port (a, b, carryin : in std_logic;
				opcode : in std_logic_vector (2 downto 0);
				result, carryout: out std_logic);
	end component;
	
	component XOR_GATE
		port(in1, in2 : in std_logic;
			  out1 : out std_logic);
	end component;
	
	component opcode_MUX
		port (opcode: in std_logic_vector (2 downto 0); 
				outN: out std_logic);
	end component;
	
	component comp_geq_not
		port (opcode: in std_logic_vector (2 downto 0); 
				input: in std_logic_vector (15 downto 0);
				output: out std_logic_vector (15 downto 0));
	end component;
	
	component result_MUX
		port (op_bit, ALU_overflow : in std_logic;
				res_ALU, res_Comp: in std_logic_vector (15 downto 0);
				output: out std_logic_vector (15 downto 0);
				carryout: out std_logic);
	end component;
	
	
	signal cout, comp_out, result : std_logic_vector(15 downto 0);
	signal MUX_out, overflow		: std_logic;
	signal opcode   					: std_logic_vector (2 downto 0);
	
begin

	opcode <= opcod(2) & opcod(1) & opcod(0);
	
	U0: ALU_Slice_Type1 port map(in1(0), in2(0), opcode, result(0), cout(0));
	
	GEN_ALU: for i in 1 to 15 generate
		 ALU: ALU_Slice_Type2 port map(in1(i), in2(i), cout(i - 1), opcode, result(i), cout(i));
	end generate;
	
	U1: XOR_GATE port map(cout(14), cout(15), overflow);
	
	U2: opcode_MUX port map (opcode, MUX_out);
	
	U3: comp_geq_not port map (opcode, in1, comp_out);
	
	U4: result_MUX port map (MUX_out, overflow, result, comp_out, res, carryout);

end STRUCTURE_ALU;
