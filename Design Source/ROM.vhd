----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2024 04:44:23 PM
-- Design Name: 
-- Module Name: ROM - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    Port ( MemSelect : in STD_LOGIC_VECTOR (2 downto 0);
           InstructionBus : out STD_LOGIC_VECTOR (12 downto 0));
end ROM;

architecture Behavioral of ROM is

type rom_type is array (0 to 7) of std_logic_vector(12 downto 0); 
signal program_ROM : rom_type := (
        "0101110000110", -- MOVI R7,6
        "1101110000000", -- NOT R7 -- R7 <= 9
        "0100100000101", -- MOVI R2,5
        "1000010100000", -- AND R7,R2  -- R7 <= 1
        "1010100010000", -- OR R2,R7 -- R2 <= 5
        "1110100110000", -- CMP R2,R3 -- G
        "1110000100000", -- CMP R0,R2 -- S
        "1110110110000"  -- CMP R3,R3 -- E
        );

begin
    InstructionBus <= program_ROM(to_integer(unsigned(MemSelect)));
end Behavioral;
