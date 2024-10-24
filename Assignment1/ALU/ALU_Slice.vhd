-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- 2 input MUX (for the input and invert)
library ieee;
use ieee.std_logic_1164.all;
 
entity MUX2to1 is
	port (N, invert: in std_logic; 
			outN: out std_logic);
end MUX2to1;
 
architecture STRUCTURE_MUX2to1 of MUX2to1 is
begin
	with invert select
	outN <=	N when '0',
				not N when others;
end STRUCTURE_MUX2to1;


-- KAI ENA 3MUXTO2 GIA TIN EPILOGI BASIC OPERATION
library ieee;
use ieee.std_logic_1164.all;

entity MUX3to2 is
	port (op_code : in std_logic_vector (2 downto 0);
			res: out std_logic_vector (1 downto 0));
end MUX3to2;


architecture STRUCTURE_MUX3to2 of MUX3to2 is
begin
	process (op_code)
	begin
		-- FullAdder gia ADD kai SUB
		if (op_code = "000" or op_code = "001") then
			res <= "00";
		-- AND_GATE gia AND kai NOR
		elsif (op_code = "010" or op_code = "111") then
			res <= "01";
		-- OR_GATE
		elsif (op_code = "011") then
			res <= "10";
		-- XOR_GATE
		elsif (op_code = "110") then
			res <= "11";
		end if;
	end process;
end STRUCTURE_MUX3to2;


-- KAI ENA 3MUXTO1 GIA TO B' INVERT
library ieee;
use ieee.std_logic_1164.all;

entity MUX3to1B is
	port (op_code : in std_logic_vector (2 downto 0);
			res: out std_logic);
end MUX3to1B;


architecture STRUCTURE_MUX3to1B of MUX3to1B is
begin
	process (op_code)
	begin
		case op_code is
			-- for SUB kai NOR invert 2nd input
			when "001" | "111" => res <= '1';
			when others => res <= '0';
		end case;
	end process;
end STRUCTURE_MUX3to1B;


-- KAI ENA 3MUXTO1 GIA TO B' INVERT
library ieee;
use ieee.std_logic_1164.all;

entity MUX3to1FA is
	port (op_code : in std_logic_vector (2 downto 0);
			res: out std_logic);
end MUX3to1FA;


architecture STRUCTURE_MUX3to1FA of MUX3to1FA is
begin
	process (op_code)
	begin
		if(op_code = "000") then
			res <= '0';
		elsif (op_code = "001") then
			res <= '1';
		end if;
	end process;
end STRUCTURE_MUX3to1FA;


-- KAI ENA 3MUXTO1
library ieee;
use ieee.std_logic_1164.all;

entity MUX3to1 is
	port (op_code : in std_logic_vector (2 downto 0);
			res: out std_logic);
end MUX3to1;


architecture STRUCTURE_MUX3to1 of MUX3to1 is
begin
	process (op_code)
	begin
		if (op_code = "111") then
			res <= '1';
		else
			res <= '0';
		end if;
	end process;
end STRUCTURE_MUX3to1;



-- KAI ENA 4MUXTO1 GIA TA 4 BASIC GATES
library ieee;
use ieee.std_logic_1164.all;

entity MUX4to1 is
	port (out_AND, out_OR, out_XOR, out_FA: in std_logic; 
			op_code : in std_logic_vector (1 downto 0);
			outN: out std_logic);
end MUX4to1;


architecture STRUCTURE_MUX4to1 of MUX4to1 is
begin
	process (out_AND, out_OR, out_XOR, out_FA, op_code)
	begin
		case op_code is
			when "00" => outN <= out_FA;
			when "01" => outN <= out_AND;
			when "10" => outN <= out_OR;
			when others => outN <= out_XOR;
		end case;
	end process;
end STRUCTURE_MUX4to1;



-- USES ONLY FOUR BASIC GATES
-- AND, OR, XOR, FULLADDER

-- 1-bit ALU Type 1
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ALU_Slice_Type1 is
	port (a, b : in std_logic;
			opcode : in std_logic_vector (2 downto 0);
			result, carryout: out std_logic);
end ALU_Slice_Type1;

architecture STRUCTURE_ALU_Slice_Type1 of ALU_Slice_Type1 is

	component MUX2to1        
		port (N, invert: in std_logic; 
				outN: out std_logic);
	end component;
	
	component MUX3to2 
		port (op_code : in std_logic_vector (2 downto 0);
				res: out std_logic_vector (1 downto 0));
	end component;
	
	component MUX3to1B
		port (op_code : in std_logic_vector (2 downto 0);
				res: out std_logic);
	end component;
	
	component MUX3to1FA
		port (op_code : in std_logic_vector (2 downto 0);
				res: out std_logic);
	end component;
	
	component MUX3to1
		port (op_code : in std_logic_vector (2 downto 0);
				res: out std_logic);
	end component;
	
	component MUX4to1
		port (out_AND, out_OR, out_XOR, out_FA: in std_logic; 
				op_code : in std_logic_vector (1 downto 0);
				outN: out std_logic);
	end component;
	
	component AND_GATE
		port (in1,in2: in std_logic; 
				out1: out std_logic);
	end component;

	component OR_GATE          
		port (in1,in2: in std_logic; 
				out1: out std_logic);
	end component;

	component XOR_GATE          
		port (in1,in2: in std_logic; 
				out1: out std_logic);
	end component;

	component FullAdder     
		port(carryin, input1, input2: in std_logic; 
				sum, carryout: out std_logic);
	end component;   

	signal res0 								  : std_logic_vector(1 downto 0);
	signal res1, res2, res3, outm0, outm1 : std_logic;
	signal outAND, outOR, outXOR, outFA   : std_logic;
	
begin
	A0: MUX3to2   port map (opcode, res0);
	A1: MUX3to1   port map (opcode, res1);
	A2: MUX3to1B  port map (opcode, res2);
	A3: MUX3to1FA   port map (opcode, res3);
	
	U0: MUX2to1   port map (a, res1, outm0);
	U1: MUX2to1   port map (b, res2, outm1);
	
	U2: AND_GATE  port map (outm0, outm1, outAND);
	U3: OR_GATE   port map (outm0, outm1, outOR);
	U4: XOR_GATE  port map (outm0, outm1, outXOR);
	U5: FullAdder port map (res3, outm0, outm1, outFA, carryout);

	U6: MUX4to1   port map (outAND, outOR, outXOR, outFA, res0, result);
end STRUCTURE_ALU_Slice_Type1;




-- 1-bit ALU Type 2
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ALU_Slice_Type2 is
	port (a, b, carryin : in std_logic;
			opcode : in std_logic_vector (2 downto 0);
			result, carryout: out std_logic);
end ALU_Slice_Type2;

architecture STRUCTURE_ALU_Slice_Type2 of ALU_Slice_Type2 is

	component MUX2to1        
		port (N, invert: in std_logic; 
				outN: out std_logic);
	end component;
	
	component MUX3to2 
		port (op_code : in std_logic_vector (2 downto 0);
				res: out std_logic_vector (1 downto 0));
	end component;
	
	component MUX3to1B
		port (op_code : in std_logic_vector (2 downto 0);
				res: out std_logic);
	end component;
	
	component MUX3to1
		port (op_code : in std_logic_vector (2 downto 0);
				res: out std_logic);
	end component;
	
	component MUX4to1
		port (out_AND, out_OR, out_XOR, out_FA: in std_logic; 
				op_code : in std_logic_vector (1 downto 0);
				outN: out std_logic);
	end component;
	
	component AND_GATE
		port (in1,in2: in std_logic; 
				out1: out std_logic);
	end component;

	component OR_GATE          
		port (in1,in2: in std_logic; 
				out1: out std_logic);
	end component;

	component XOR_GATE          
		port (in1,in2: in std_logic; 
				out1: out std_logic);
	end component;

	component FullAdder     
		port(carryin, input1, input2: in std_logic; 
				sum, carryout: out std_logic);
	end component;   

	signal res0 						  		: std_logic_vector(1 downto 0);
	signal res1, res2, outm0, outm1 		: std_logic;
	signal outAND, outOR, outXOR, outFA : std_logic;
	
begin
	A0: MUX3to2   port map (opcode, res0);
	A1: MUX3to1   port map (opcode, res1);
	A2: MUX3to1B  port map (opcode, res2);
	
	U0: MUX2to1   port map (a, res1, outm0);
	U1: MUX2to1   port map (b, res2, outm1);
	
	U2: AND_GATE  port map (outm0, outm1, outAND);
	U3: OR_GATE   port map (outm0, outm1, outOR);
	U4: XOR_GATE  port map (outm0, outm1, outXOR);
	U5: FullAdder port map (carryin, outm0, outm1, outFA, carryout);

	U6: MUX4to1   port map (outAND, outOR, outXOR, outFA, res0, result);
end STRUCTURE_ALU_Slice_Type2;

