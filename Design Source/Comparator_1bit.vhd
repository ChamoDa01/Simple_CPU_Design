----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2024 15:04:34
-- Design Name: 
-- Module Name: Comparator_1bit - Behavioral
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

entity Comparator_1bit is
    Port ( G_in : in STD_LOGIC;
           S_in : in STD_LOGIC;
           E_in : in STD_LOGIC;
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           G_out : out STD_LOGIC;
           S_out : out STD_LOGIC;
           E_out : out STD_LOGIC);
end Comparator_1bit;

architecture Behavioral of Comparator_1bit is

signal Greater,Smaller,Equal: std_logic;

begin

	Greater <= (E_in and A and not(B)) or G_in;
    Smaller <= (E_in and not(A) and B) or S_in;
    Equal <= (A and B) or (not(A) and not(B));
    
    G_out <= Greater;
    S_out <= Smaller;
    E_out <= Equal and E_in;

end Behavioral;
