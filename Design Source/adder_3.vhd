----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2024 05:04:41 PM
-- Design Name: 
-- Module Name: 3_adder - Behavioral
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

entity Adder_3 is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           Increment : out STD_LOGIC_VECTOR (2 downto 0));
end Adder_3;

architecture Behavioral of Adder_3 is

component FA
    PORT ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S : out STD_LOGIC;
           C_out : out STD_LOGIC
    );
end component;

SIGNAL FA0_S,FA1_S,FA2_S : std_logic;
SIGNAL FA0_C, FA1_C, FA2_c: std_logic;

begin
    -- B is always one since this Adder is to increment the address by 1--
    FA_0 : FA
    PORT MAP (
        A => A(0),
        B => '1',
        C_in => '0',
        S => FA0_S,
        C_out => FA0_C
    );

    FA_1 : FA
    PORT MAP (
        A => A(1),
        B => '0',
        C_in => FA0_C,
        S => FA1_S,
        C_out => FA1_C
    );
    
    FA_2 : FA
    PORT MAP (
        A => A(2),
        B => '0',
        C_in => FA1_C,
        S => FA2_S,
        C_out=> FA2_C
    );
    
    Increment(0) <= FA0_S;
    Increment(1) <= FA1_S;
    Increment(2) <= FA2_S;

end Behavioral;
