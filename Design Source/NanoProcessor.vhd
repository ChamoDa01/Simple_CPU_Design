----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 11:27:42 AM
-- Design Name: 
-- Module Name: NanoProcessor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NanoProcessor is
    Port ( Processor_Reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR(6 downto 0);
           an : out STD_LOGIC_VECTOR(3 downto 0);
           Zero : out STD_LOGIC := '0';
           Overflow : out STD_LOGIC := '0');
end NanoProcessor;

architecture Behavioral of NanoProcessor is

component RegBank is
    Port ( Value : in STD_LOGIC_VECTOR (3 downto 0);
           Clk : in STD_LOGIC;
           RegEN : in STD_LOGIC_VECTOR (2 downto 0);
           Reset : in STD_LOGIC;
           Q0 : out STD_LOGIC_VECTOR (3 downto 0);
           Q1 : out STD_LOGIC_VECTOR (3 downto 0);
           Q2 : out STD_LOGIC_VECTOR (3 downto 0);
           Q3 : out STD_LOGIC_VECTOR (3 downto 0);
           Q4 : out STD_LOGIC_VECTOR (3 downto 0);
           Q5 : out STD_LOGIC_VECTOR (3 downto 0);
           Q6 : out STD_LOGIC_VECTOR (3 downto 0);
           Q7 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Mux_8_to_1 is
    Port ( muxIN0 : in STD_LOGIC_VECTOR (3 downto 0);
           muxIN1 : in STD_LOGIC_VECTOR (3 downto 0);
           muxIN2 : in STD_LOGIC_VECTOR (3 downto 0);
           muxIN3 : in STD_LOGIC_VECTOR (3 downto 0);
           muxIN4 : in STD_LOGIC_VECTOR (3 downto 0);
           muxIN5 : in STD_LOGIC_VECTOR (3 downto 0);
           muxIN6 : in STD_LOGIC_VECTOR (3 downto 0);
           muxIN7 : in STD_LOGIC_VECTOR (3 downto 0);
           RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           muxOut : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component RCAS_4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (3 downto 0);
           M : in STD_LOGIC;
           Carry : out STD_LOGIC;
           Overflow : out STD_LOGIC );
end component;

component MUX_2_to_1_4bit is
    Port ( MuxIn1 : in STD_LOGIC_VECTOR (3 downto 0);
           MuxIn2  : in STD_LOGIC_VECTOR (3 downto 0);
           LoadSel : in STD_LOGIC;
           MuxOut_4 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Instruction_Decoder is
    Port ( InsBus : in STD_LOGIC_VECTOR (12 downto 0);
           CheckValue : in STD_LOGIC_VECTOR (3 downto 0);
           AddSubSel : out STD_LOGIC;
           RegEnable : out STD_LOGIC_VECTOR (2 downto 0);
           LoadSelect1 : out STD_LOGIC;
           LoadSelect2 : out STD_LOGIC;
           Logic_Func : out STD_LOGIC_VECTOR(1 downto 0);
           ImmediateValue : out STD_LOGIC_VECTOR (3 downto 0);
           RegSelect1 : out STD_LOGIC_VECTOR (2 downto 0);
           RegSelect2 : out STD_LOGIC_VECTOR (2 downto 0);
           JumpFlag : out STD_LOGIC;
           AddressJ : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Adder_3 is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           Increment : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component MUX_2_to_1_3bit is
    Port ( Address_to_Jump : in STD_LOGIC_VECTOR (2 downto 0);
           Incremented_Address : in STD_LOGIC_VECTOR (2 downto 0);
           Jump_Flag : in STD_LOGIC;
           Next_Address : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component ROM is
    Port ( MemSelect : in STD_LOGIC_VECTOR (2 downto 0);
           InstructionBus : out STD_LOGIC_VECTOR (12 downto 0));
end component;

component PC is
    Port ( Next_Adress : in STD_LOGIC_VECTOR(2 downto 0);
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Memory_Select : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Slow_Clk is
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end component;

component Logical_OP is
    Port ( IN_A : in STD_LOGIC_VECTOR (3 downto 0);
           IN_B : in STD_LOGIC_VECTOR (3 downto 0);
           Func_Sel : in STD_LOGIC_VECTOR (1 downto 0);
           Result : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component LUT_16_7 is
    Port ( address : in STD_LOGIC_VECTOR(3 downto 0);
           data : out STD_LOGIC_VECTOR(6 downto 0));      
end component;


Signal MuxOut_4_0,MuxOut_4_1 : STD_LOGIC_VECTOR (3 downto 0);

Signal Slw_Clk : STD_LOGIC;

--RegBank Signals--
Signal RegEnable : STD_LOGIC_VECTOR (2 downto 0);
Signal Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7 : STD_LOGIC_VECTOR (3 downto 0);
 

Signal muxOut1, muxOut2 :  STD_LOGIC_VECTOR (3 downto 0);

-- Adder/Subtractor signals--
Signal RCAS_out : STD_LOGIC_VECTOR(3 downto 0);
Signal carry, RCAS_Overflow : STD_LOGIC;

--Instruction Decoder Signals--
Signal InsBus : STD_LOGIC_VECTOR (12 downto 0);
Signal AddSubSel : STD_LOGIC;
Signal LoadSelect1,LoadSelect2 : STD_LOGIC;
Signal Func_Select : STD_LOGIC_VECTOR(1 downto 0);
Signal ImmediateValue :  STD_LOGIC_VECTOR (3 downto 0);
Signal RegSelect1, RegSelect2 :  STD_LOGIC_VECTOR (2 downto 0);
Signal JumpFlag :  STD_LOGIC;
Signal AddressJ :  STD_LOGIC_VECTOR (2 downto 0);


Signal Incremented_Address : STD_LOGIC_VECTOR (2 downto 0);
Signal Next_Adress :  STD_LOGIC_VECTOR(2 downto 0);

Signal Mem_Select : STD_LOGIC_VECTOR (2 downto 0);

Signal S_7Seg : STD_LOGIC_VECTOR(6 downto 0);
Signal Logic_Res : STD_LOGIC_VECTOR(3 downto 0);

begin

    
    reg_bank : RegBank
        port map(
        Value => MuxOut_4_0,
        Clk => Slw_Clk, --Slowed Clock
        RegEN => RegEnable,
        Reset => Processor_Reset,
        Q0 => Q0,
        Q1 => Q1,
        Q2 => Q2,
        Q3 => Q3,
        Q4 => Q4,
        Q5 => Q5,
        Q6 => Q6,
        Q7 => Q7);
    
    Seg7Display : LUT_16_7
        Port map(  
        address => Q7, -- Final Result Is in Reg 7 
        data => S_7Seg);
    
    Mux_8_to_1_1 : Mux_8_to_1
        port map(
        muxIN0 => Q0,
        muxIN1 => Q1,
        muxIN2 => Q2,
        muxIN3 => Q3,
        muxIN4 => Q4,
        muxIN5 => Q5,
        muxIN6 => Q6,
        muxIN7 => Q7,
        RegSel => RegSelect1,
        muxOut => muxOut1);
    
    Mux_8_to_1_2 : Mux_8_to_1
        port map(
        muxIN0 => Q0,
        muxIN1 => Q1,
        muxIN2 => Q2,
        muxIN3 => Q3,
        muxIN4 => Q4,
        muxIN5 => Q5,
        muxIN6 => Q6,
        muxIN7 => Q7,
        RegSel => RegSelect2,
        muxOut => muxOut2);
        
    ADD_SUB_4bit : RCAS_4
        port map(
        A => muxOut2,
        B => muxOut1,
        S => RCAS_Out,
        M => AddSubSel,
        Carry => carry, -- Carry bit of ADD/SUB
        Overflow => RCAS_Overflow); 
        
    Logical_OP_4bit : Logical_OP
        port map ( 
        IN_A => muxOut1,
        IN_B => muxOut2,
        Func_Sel =>  Func_Select,
        Result => Logic_Res );
                   
         
    MUX_2_to_1_4b_0 : MUX_2_to_1_4bit
        Port map (
        MuxIn1 => MuxOut_4_1,
        MuxIn2 => ImmediateValue,
        LoadSel => LoadSelect1,
        MuxOut_4 => MuxOut_4_0);
    
    MUX_2_to_1_4b_1 : MUX_2_to_1_4bit
        Port map (
        MuxIn1 => RCAS_Out,
        MuxIn2 => Logic_Res,
        LoadSel => LoadSelect2,
        MuxOut_4 => MuxOut_4_1);
      
           
    Instruction_Dec : Instruction_Decoder
        port map ( 
        InsBus => InsBus,
        CheckValue => muxOut1,
        AddSubSel => AddSubSel ,
        RegEnable => RegEnable,
        LoadSelect1 => LoadSelect1,
        LoadSelect2 => LoadSelect2,
        Logic_Func => Func_Select,
        ImmediateValue => ImmediateValue,
        RegSelect1 => RegSelect1,
        RegSelect2 => RegSelect2,
        JumpFlag => JumpFlag,
        AddressJ => AddressJ); -- Address to jump --
        
     
    Adder_3bit : Adder_3
        port map( 
        A => Mem_Select,
        Increment => Incremented_Address);
        
    
    Mux_2_to_1_3b : MUX_2_to_1_3bit
        port map (
         Address_to_Jump => AddressJ ,
         Incremented_Address => Incremented_Address,
         Jump_Flag => JumpFlag,
         Next_Address => Next_Adress);
         
         
    Programme_Counter : PC
        port map ( 
        Next_Adress => Next_Adress,
        Res => Processor_Reset, -- PC and RegBank shares the same reset signal
        Clk => Slw_Clk,
        Memory_Select => Mem_Select);
        
        
    rom_0 : ROM 
        port map ( 
        MemSelect => Mem_Select ,
        InstructionBus => InsBus);    
                      
  
    Clock : Slow_Clk 
        port map ( 
        Clk_in => clk,
        Clk_out => Slw_Clk);
        
    led <= Q7;
    seg <= S_7Seg;
    an <= "1110"; -- right most 7 Seg display is enabled while others are disabled
    Zero <=  Not(RCAS_Out(0) or RCAS_Out(1) or RCAS_Out(2) or RCAS_Out(3))and Not(InsBus(11)) and Not(InsBus(10));
    Overflow <= RCAS_Overflow and Not(InsBus(11)) and Not(InsBus(10));    

end Behavioral;
