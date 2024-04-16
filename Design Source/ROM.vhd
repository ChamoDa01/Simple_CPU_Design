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
        "0100010001010", -- MOVI R1,10
        "0100100000001", -- MOVI R2,1
        "0010100000000", -- NEG R2
        "0000010100000", -- ADD R1,R2
        "0110010000111", -- JNZ R1,7
        "0110000000011", -- JNZ R0,4
        "0000000000000", -- 
        "ZZZZZZZZZZZZZ"  -- High Imp.
        );

begin
    InstructionBus <= program_ROM(to_integer(unsigned(MemSelect)));
end Behavioral;
