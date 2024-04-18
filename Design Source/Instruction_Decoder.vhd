----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2024 03:07:55 PM
-- Design Name: 
-- Module Name: Instruction_Decoder - Behavioral
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

entity Instruction_Decoder is
    Port ( InsBus : in STD_LOGIC_VECTOR (12 downto 0);
           CheckValue : in STD_LOGIC_VECTOR (3 downto 0);
           AddSubSel : out STD_LOGIC;
           RegEnable : out STD_LOGIC_VECTOR (2 downto 0);
           LoadSelect1 : out STD_LOGIC;
           LoadSelect2 : out STD_LOGIC;
           Logic_Func : out STD_LOGIC_VECTOR(2 downto 0);
           ImmediateValue : out STD_LOGIC_VECTOR (3 downto 0);
           RegSelect1 : out STD_LOGIC_VECTOR (2 downto 0);
           RegSelect2 : out STD_LOGIC_VECTOR (2 downto 0);
           JumpFlag : out STD_LOGIC := '0';
           AddressJ : out STD_LOGIC_VECTOR (2 downto 0));
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is

begin

    RegEnable <= InsBus(9 downto 7);
    LoadSelect1 <= not(InsBus(12)) and InsBus(11) and not(InsBus(10));
    LoadSelect2 <= InsBus(12);
    Logic_Func <= InsBus(12 downto 10);
    ImmediateValue <= InsBus(3 downto 0);
    RegSelect1 <= InsBus(9 downto 7);
    RegSelect2 <= InsBus(6 downto 4);
    AddSubSel <= not(InsBus(11)) and InsBus(10);
    JumpFlag <= not(CheckValue(0) or CheckValue(1) or CheckValue(2) or CheckValue(3)) and InsBus(11) and InsBus(10);
    AddressJ <= InsBus(2 downto 0);
    
end Behavioral;
