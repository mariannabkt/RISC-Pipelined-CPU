-- VASILIKI-SEIDA KOLOVOU P3190086
-- MARIANNA BAKTI P3190128

-- RISC pipelined CPU

library ieee;
use ieee.std_logic_1164.all;

entity RISC_pipelined_CPU is
	port (clock1 			: in std_logic;
			clock2 			: in std_logic;
			keyData 			: in std_logic_vector (15 downto 0);
			fromData 		: in std_logic_vector (15 downto 0);
			instr 			: in std_logic_vector (15 downto 0);

			printEnable 	: out std_logic;
			keyEnable 		: out std_logic;
			DataWriteFlag 	: out std_logic;
			dataAD 			: out std_logic_vector (15 downto 0);
			toData 			: out std_logic_vector (15 downto 0);
			printCode 		: out std_logic_vector (15 downto 0);
			printData 		: out std_logic_vector (15 downto 0);
			instructionAD 	: out std_logic_vector (15 downto 0);
			regOUT 			: out std_logic_vector (143 downto 0));
end RISC_pipelined_CPU;

architecture funcRISC_pipelined_CPU of RISC_pipelined_CPU is

	component Register_IF_ID
		port (IF_Flush 		: in std_logic;
				IF_ID_Enable 	: in std_logic;
				clock 			: in std_logic;
				PCin 				: in std_logic_vector (15 downto 0);
				Command 			: in std_logic_vector (15 downto 0);
				
				PCout 			: out std_logic_vector (15 downto 0);
				Commandout 		: out std_logic_vector (15 downto 0));
	end component;
	
	component Register_ID_EX
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
	end component;
	
	component Register_EX_MEM
		port (clock              	: in std_logic;
            isLW               	: in std_logic;
            WriteEnable        	: in std_logic;
            ReadDigit          	: in std_logic;
            PrintDigit         	: in std_logic;
            R2Reg              	: in std_logic_vector(15 downto 0);
            Result             	: in std_logic_vector(15 downto 0);
            RegAD              	: in std_logic_vector(2 downto 0);

				isLW_EX_MEM				: out std_logic;
				WriteEnable_EX_MEM	: out std_logic;
				ReadDigit_EX_MEM		: out std_logic;
				PrintDigit_EX_MEM 	: out std_logic;
				R2Reg_EX_MEM 			: out std_logic_vector (15 downto 0);
				Result_EX_MEM 			: out std_logic_vector (15 downto 0);
				RegAD_EX_MEM 			: out std_logic_vector (2 downto 0));
	end component;
	
	component Register_MEM_WB
		port (clock 			: in std_logic;
				regAddress 		: in std_logic_vector (2 downto 0);
				Result 			: in std_logic_vector (15 downto 0);
			
				writeAddress 	: out std_logic_vector (2 downto 0);
				writeData 		: out std_logic_vector (15 downto 0));
	end component;
	
	component forwarder
		port (regRS_address		: in std_logic_vector (2 downto 0); 
				regRT_address		: in std_logic_vector (2 downto 0); 
				regRD_EX_address 	: in std_logic_vector (2 downto 0);
				regRD_MEM_address : in std_logic_vector (2 downto 0);
			
				ForwardA				: out std_logic_vector (1 downto 0);
				ForwardB 			: out std_logic_vector (1 downto 0));
	end component;
	
	component Selector
		port (regAddress	: in std_logic_vector (15 downto 0);
				regAD_MEM 	: in std_logic_vector (15 downto 0);
				regAD_WB		: in std_logic_vector (15 downto 0);
				operation 	: in std_logic_vector (1 downto 0);
			
				Output 		: out std_logic_vector (15 downto 0));
	end component;
	
	component hazardUnit
		port (isJR			: in std_logic;
				isJump		: in std_logic; 
				wasJump 		: in std_logic;
				shouldBranch: in std_logic;
			
			
				IF_ID_Flush	: out std_logic;
				wasJumpOut 	: out std_logic;
				JROpCode 	: out std_logic_vector (1 downto 0));
	end component;
	
	component trapUnit
		port (opCode 		 : in std_logic_vector (3 downto 0);
				endOfRunning : out std_logic);
	end component;
	
	component JRSelector
		port(	jumpAD		: in std_logic_vector (15 downto 0); 
				branchAd		: in std_logic_vector (15 downto 0); 
				PCP2AD 		: in std_logic_vector (15 downto 0);
				JRopcode 	: in std_logic_vector (1 downto 0);
			
				result 		: out std_logic_vector (15 downto 0));
	end component;
	
	component PCRegister
		port (Input  : in std_logic_vector (15 downto 0);
				Enable : in std_logic;
				Clock  : in std_logic;
			
				Output : out std_logic_vector (15 downto 0));
	end component;
	
	component reg16bit is
		port (clock, enable: in std_logic;
				input:  in  std_logic_vector (15 downto 0);
				output: out std_logic_vector (15 downto 0)); 
	end component;
	
	component controller
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
	end component;
	
	component regFile
		port (Clock			: in std_logic;
				Read1AD		: in std_logic_vector(2 downto 0);
				Read2AD		: in std_logic_vector(2 downto 0);
				Write1AD		: in std_logic_vector(2 downto 0);
				Write1		: in std_logic_vector(15 downto 0);
				
				OUTall		: out std_logic_vector(127 downto 0);
				Read1			: out std_logic_vector (15 downto 0);
				Read2			: out std_logic_vector (15 downto 0));
	end component;
	
	component ALU16bit is
		port (in1, in2 : in std_logic_vector (15 downto 0);
				opcod    : in std_logic_vector (3 downto 0);
				
				res   	: out std_logic_vector (15 downto 0);
				carryout : out std_logic);
	end component;
	
	component alu_control
		port (opcode	: in std_logic_vector(3 downto 0);
				func		: in std_logic_vector(2 downto 0);
				
				ALUoperation: out std_logic_vector(3 downto 0));
	end component;
	
	component SignExtender
		port (immediate : in std_logic_vector(5 downto 0); 
	
				extended	 : out std_logic_vector(15 downto 0));
	end component;
	
	
--	signal clock1				: std_logic;
	signal isEOR_signal		: std_logic;
	signal wasJumpOut_signal: std_logic;
	signal isJump_signal		: std_logic;
	signal isJR_signal		: std_logic;
	signal isBranch_signal	: std_logic;
	signal isR_signal			: std_logic;
	signal isMFPC_signal		: std_logic;
	signal isLW_signal		: std_logic;
	signal isSW_signal		: std_logic;
	signal isReadDig_signal	: std_logic;
	signal isPrintDig_signal: std_logic;
	signal flush 				: std_logic;
	signal carryOut 			: std_logic;
	signal isEOR_IDEX			: std_logic;
	signal wasJump_IDEX		: std_logic;
	signal isJump_IDEX		: std_logic;
	signal isJR_IDEX			: std_logic;
	signal isBranch_IDEX		: std_logic;
	signal isR_IDEX			: std_logic;
	signal isMFPC_IDEX		: std_logic;
	signal isLW_IDEX			: std_logic;
	signal isSW_IDEX			: std_logic;
	signal isRD_IDEX			: std_logic;
	signal isWD_IDEX			: std_logic;
	signal isLW_EXMEM			: std_logic;
	signal WriteEnable_EXMEM: std_logic;
	signal RD_EXMEM			: std_logic;
	signal WD_EXMEM			: std_logic;
	signal jrOpcode 			: std_logic_vector(1 downto 0);
	signal forwardSignal1 	: std_logic_vector(1 downto 0);
	signal forwardSignal2 	: std_logic_vector(1 downto 0);
	signal writeBackAD 		: std_logic_vector(2 downto 0);
	signal memRegAD 			: std_logic_vector(2 downto 0);
	signal R1AD_ID_EX			: std_logic_vector(2 downto 0);
	signal R2AD_ID_EX			: std_logic_vector(2 downto 0);
	signal regAddressOut		: std_logic_vector(2 downto 0);
	signal ALUOp 				: std_logic_vector(3 downto 0);
	signal ALUOp_ID_EX		: std_logic_vector(3 downto 0);
	signal jumpAddress		: std_logic_vector(11 downto 0);
	signal PC_out 				: std_logic_vector(15 downto 0); 
	signal IF_ID_PCout 		: std_logic_vector(15 downto 0); 
	signal IF_ID_Commandout : std_logic_vector(15 downto 0);
	signal regData1			: std_logic_vector(15 downto 0);
	signal regData2			: std_logic_vector(15 downto 0);
	signal ALUResult			: std_logic_vector(15 downto 0);
	signal writeData 			: std_logic_vector(15 downto 0);
	signal signExtendedImm 	: std_logic_vector(15 downto 0);
	signal jumpAddressExt	: std_logic_vector(15 downto 0);
	signal branchAddress 	: std_logic_vector(15 downto 0);
	signal writeBackData 	: std_logic_vector(15 downto 0);
	signal regData1_ID_EX	: std_logic_vector(15 downto 0);
	signal regData2_ID_EX	: std_logic_vector(15 downto 0);
	signal selected_out1		: std_logic_vector(15 downto 0);
	signal selected_out2		: std_logic_vector(15 downto 0);
	signal selector1_out		: std_logic_vector(15 downto 0);
	signal selector2_out		: std_logic_vector(15 downto 0);
	signal R2Reg_EXMEM		: std_logic_vector(15 downto 0);
	signal Result_EXMEM		: std_logic_vector(15 downto 0);
	signal selectedJRAddress: std_logic_vector(15 downto 0);
	signal dataSelectOut1	: std_logic_vector(15 downto 0);
	signal dataSelectOut2	: std_logic_vector(15 downto 0);
	signal OUTall				: std_logic_vector(127 downto 0);


begin

    -- Instruction Fetch (IF) stage
	 u_PCRegister: PCRegister port map (
		Input  => selectedJRAddress,
		Enable => not (isEOR_signal or isEOR_IDEX),
		Clock  => clock1,
		
		Output => PC_out);
		
--	u_PCRegister: reg16bit port map (
--		Clock  => clock1,
--		Enable => not (isEOR_signal or isEOR_IDEX),
--		Input  => selectedJRAddress,
--		
--		Output => PC_out);

	-- Instruction Fetch to Decode (IF-ID) stage
	u_Register_IF_ID: Register_IF_ID port map (
		IF_Flush    	=> '0',
		IF_ID_Enable 	=> '1',
		clock       	=> clock1,
		PCin           => PC_out,
		Command        => instr,
		
		PCout          => IF_ID_PCout,
		Commandout     => IF_ID_Commandout);

	-- Instruction Decode (ID) stage
	u_hazardUnit: hazardUnit port map (
		isJR          => isJR_signal,
		isJump        => isJump_signal,
		wasJump       => '0',
		shouldBranch  => carryOut and isBranch_IDEX,
		
		IF_ID_Flush   => flush,
		wasJumpOut    => wasJumpOut_signal,
		JROpCode      => jrOpcode);

	u_controller: controller port map (
		IF_ID_Flush  => flush or isEOR_IDEX,
		OpCode       => IF_ID_Commandout(15 downto 12),
      func         => IF_ID_Commandout(2 downto 0),
		
		isRType      => isR_signal,
		isBranch     => isBranch_signal,
		isJReg       => isJR_signal,
		isJType      => isJump_signal,
		isLdWord     => isLW_signal,
		isStWord     => isSW_signal,
		isMPFC       => isMFPC_signal,
		isReadDig    => isReadDig_signal,
		isWriteDig   => isPrintDig_signal);
		
	selectRegister : process(isR_signal) 
	begin
		case isR_signal is
			when '1'  =>
				regAddressOut <= IF_ID_Commandout(5 downto 3);
			when '0'  => 
				regAddressOut <= IF_ID_Commandout(11 downto 9);
			when others => 
				regAddressOut <= IF_ID_Commandout(11 downto 9);
		end case;
	end process;
		
	u_regFile: regFile port map (
		Clock      => clock2,
		Read1AD    => IF_ID_Commandout(11 downto 9),
      Read2AD    => regAddressOut,
		Write1AD   => writeBackAD,
		Write1     => writeBackData,
		
		OUTall     => OUTall,
		Read1      => regData1,
		Read2      => regData2);
		
	u_trapUnit: trapUnit port map (
		opCode       => IF_ID_Commandout(15 downto 12),
		
		endOfRunning => isEOR_signal);

	u_SignExtender: SignExtender port map (
		immediate => IF_ID_Commandout(5 downto 0),
		
		extended  => signExtendedImm);

	-- Instruction Decode to Execute (ID-EX) stage
	u_Register_ID_EX: Register_ID_EX port map (
		clock               => clock1,
		isEOR               => isEOR_signal,
		wasJumpOut          => wasJumpOut_signal,
		isJump              => isJump_signal,
		isJR                => isJR_signal,
		isBranch            => isBranch_signal,
		isR                 => isR_signal,
		isMFPC              => isMFPC_signal,
		isLW                => isLW_signal,
		isSW                => isSW_signal,
		isReadDigit         => isReadDig_signal,
		isPrintDigit        => isPrintDig_signal,		
		ALUFunc             => ALUOp,
		R1Reg               => regData1,
		R2Reg               => regData2,
		immediate16         => signExtendedImm,
		R2AD                => IF_ID_Commandout(8 downto 6),
		R1AD                => IF_ID_Commandout(11 downto 9),
		jumpShortAddr       => IF_ID_Commandout(11 downto 0),
		
		isEOR_ID_EX         => isEOR_IDEX,
		wasJumpOut_ID_EX    => wasJump_IDEX,
		isJump_ID_EX        => isJump_IDEX,
		isJR_ID_EX          => isJR_IDEX,
		isBranch_ID_EX      => isBranch_IDEX,
		isR_ID_EX           => isR_IDEX,
		isMFPC_ID_EX        => isMFPC_IDEX,
		isLW_ID_EX          => isLW_IDEX,
		isSW_ID_EX          => isSW_IDEX,
		isReadDigit_ID_EX   => isRD_IDEX,
		isPrintDigit_ID_EX  => isWD_IDEX,		
		ALUFunc_ID_EX       => ALUOp_ID_EX,
		R1Reg_ID_EX         => regData1_ID_EX,
		R2Reg_ID_EX         => regData2_ID_EX,
		immediate16_ID_EX   => branchAddress,
		R2AD_ID_EX          => R2AD_ID_EX,
		R1AD_ID_EX          => R1AD_ID_EX,
		jumpShortAddr_ID_EX => jumpAddress);

	-- Execution (EX) stage
	u_forwarder: forwarder port map (
		regRS_address    	=> R1AD_ID_EX,
      regRT_address     => R2AD_ID_EX,
		regRD_EX_address 	=> memRegAD,
		regRD_MEM_address	=> writeBackAD,
		
		ForwardA         	=> forwardSignal1,
		ForwardB         	=> forwardSignal2);
		
	Result_MEMWB : process(isLW_EXMEM, RD_EXMEM) 
	begin
		if (isLW_EXMEM = '1') then
			dataSelectOut1 <= fromData;
		elsif (RD_EXMEM = '1') then
			dataSelectOut1 <= keyData;
		else 
			dataSelectOut1 <= Result_EXMEM;
		end if;
	end process;
	
	u_Selector1 : Selector port map (
		regAddress	=> regData1_ID_EX,
		regAD_MEM 	=> dataSelectOut1,
		regAD_WB		=> writeBackData,
		operation 	=> forwardSignal1,
			
		Output 		=> selected_out1);

	u_Selector2 : Selector port map (
		regAddress	=> regData2_ID_EX,
		regAD_MEM 	=> dataSelectOut1,
		regAD_WB		=> writeBackData,
		operation 	=> forwardSignal2,
			
		Output 		=> selected_out2);
		
	ALUInput1 : process(isMFPC_IDEX) 
	begin
		case isMFPC_IDEX is
			when '1'  =>
				selector1_out <= IF_ID_PCout;
			when '0'  => 
				selector1_out <= selected_out1;
			when others => 
				selector1_out <= selected_out1;
		end case;
	end process;
	
	ALUInput2 : process(isR_IDEX) 
	begin
		case isR_IDEX is
			when '1'  =>
				selector2_out <= branchAddress;
			when '0'  => 
				selector2_out <= selected_out2;
			when others => 
				selector2_out <= selected_out2;
		end case;
	end process;
	
	u_alu_control: alu_control port map (
		opcode       => IF_ID_Commandout(15 downto 12),
		func         => IF_ID_Commandout(2 downto 0),
		
		ALUoperation => ALUOp);

	u_ALU16bit: ALU16bit port map (
		in1      => selector1_out,
		in2      => selector2_out,
		opcod    => ALUOp_ID_EX,
		
		res      => ALUResult,
		carryout => carryOut);
		
	jumpAddressExt(15 downto 12) <= (others => jumpAddress(11));
	jumpAddressExt(11 downto 0) <= jumpAddress;
		
	u_JRSelector: JRSelector port map (
		jumpAD       => jumpAddressExt,
		branchAd     => branchAddress,
		PCP2AD       => IF_ID_PCout,
		JRopcode     => jrOpcode,
		
		result       => selectedJRAddress);

	-- Execute to Memory (EX-MEM) stage
	u_Register_EX_MEM: Register_EX_MEM port map (
		clock               => clock1,
		isLW                => isLW_IDEX,
		WriteEnable         => isSW_IDEX,
		ReadDigit           => isRD_IDEX,
		PrintDigit          => isWD_IDEX,
		R2Reg               => regData2_ID_EX,
		Result              => ALUResult,
		RegAD               => IF_ID_Commandout(5 downto 3),
		
		isLW_EX_MEM         => isLW_EXMEM,
		WriteEnable_EX_MEM  => WriteEnable_EXMEM,
		ReadDigit_EX_MEM    => RD_EXMEM,
		PrintDigit_EX_MEM   => WD_EXMEM,
		R2Reg_EX_MEM        => R2Reg_EXMEM,
		Result_EX_MEM       => Result_EXMEM,
		RegAD_EX_MEM        => memRegAD);
		  
	-- Memory to Write-Back (MEM-WB) stage
	u_Register_MEM_WB: Register_MEM_WB port map (
		clock         => clock1,
		regAddress    => memRegAD,
		Result        => dataSelectOut1,
		
		writeAddress  => writeBackAD,
		writeData     => writeBackData);
		
	-- comment the process for rtl
	outputs : process(clock1, WD_EXMEM, RD_EXMEM, WriteEnable_EXMEM, R2Reg_EXMEM, Result_EXMEM, PC_out, OUTall) 
	begin
		if clock1 = '1'  then 
			printEnable 	<= WD_EXMEM;
			keyEnable 		<= RD_EXMEM;
			DataWriteFlag 	<= WriteEnable_EXMEM;
			dataAD 			<= R2Reg_EXMEM;
			toData 			<= Result_EXMEM;
			printCode 		<= R2Reg_EXMEM;
			printData 		<= Result_EXMEM;
			instructionAD 	<= PC_out;
			regOUT 			<= OUTall & PC_out;
		end if;
	end process outputs;

end funcRISC_pipelined_CPU;