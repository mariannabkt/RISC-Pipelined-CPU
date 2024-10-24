-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128


-- Register File

library ieee;
use ieee.std_logic_1164.all;
 
entity regFile is
	port (Clock: in std_logic;
			Read1AD, Read2AD, Write1AD: in std_logic_vector(2 downto 0);
			Write1: in std_logic_vector(15 downto 0);
			OUTall: out std_logic_vector(127 downto 0);
			Read1, Read2: out std_logic_vector (15 downto 0));
end regFile;
 
architecture STRUCTURE_regFile of regFile is

	component reg
	generic (size : INTEGER := 15);
		port (clock, enable: in std_logic;
				input:  in  std_logic_vector (size downto 0);
				output: out std_logic_vector (size downto 0)); 
	end component;
	
	component reg0
	generic (size : INTEGER := 15);
		port (clock, enable: in std_logic;
				input:  in  std_logic_vector (size downto 0);
				output: out std_logic_vector (size downto 0));
	end component;	
	
	component MUX8to1
	port (in1, in2, in3, in4, in5, in6, in7, in8: in std_logic_vector(15 downto 0); 
			choice: in std_logic_vector(2 downto 0);
			output: out std_logic_vector(15 downto 0));
	end component;
	
	component Decoder3to8
		port (input: in std_logic_vector(2 downto 0);
				output: out std_logic_vector(7 downto 0));
	end component;

	
	signal out_Decoder_U0: std_logic_vector(7 downto 0);
	signal out_reg0_U1, out_reg_U2, out_reg_U3, out_reg_U4, out_reg_U5, 
			 out_reg_U6, out_reg_U7, out_reg_U8: std_logic_vector (15 downto 0);

begin

	U0 : Decoder3to8 port map (Write1AD, out_Decoder_U0);
	
	U1 : reg0 port map (out_Decoder_U0(0), Clock, Write1, out_reg0_U1);
	
	U2 : reg port map (out_Decoder_U0(1), Clock, Write1, out_reg_U2);
	U3 : reg port map (out_Decoder_U0(2), Clock, Write1, out_reg_U3);
	U4 : reg port map (out_Decoder_U0(3), Clock, Write1, out_reg_U4);
	U5 : reg port map (out_Decoder_U0(4), Clock, Write1, out_reg_U5);
	U6 : reg port map (out_Decoder_U0(5), Clock, Write1, out_reg_U6);
	U7 : reg port map (out_Decoder_U0(6), Clock, Write1, out_reg_U7);
	U8 : reg port map (out_Decoder_U0(7), Clock, Write1, out_reg_U8);
	
	U9 : MUX8to1 port map (out_reg0_U1, out_reg_U2, out_reg_U3, out_reg_U4, out_reg_U5, 
								  out_reg_U6, out_reg_U7, out_reg_U8, Read1AD, Read1);
	U10: MUX8to1 port map (out_reg0_U1, out_reg_U2, out_reg_U3, out_reg_U4, out_reg_U5, 
								  out_reg_U6, out_reg_U7, out_reg_U8, Read2AD, Read2);
	
	OUTall <= out_reg_U8 & out_reg_U7 & out_reg_U6 & out_reg_U5 & out_reg_U4 & out_reg_U3 & out_reg_U2 & out_reg0_U1;
	
end STRUCTURE_regFile;