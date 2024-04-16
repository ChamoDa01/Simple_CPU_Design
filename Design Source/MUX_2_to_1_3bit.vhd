----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2024 02:10:45 PM
-- Design Name: 
-- Module Name: MUX_2_to_1_3bit - Behavioral
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

entity MUX_2_to_1_3bit is
    Port ( Address_to_Jump : in STD_LOGIC_VECTOR (2 downto 0);
           Incremented_Address : in STD_LOGIC_VECTOR (2 downto 0);
           Jump_Flag : in STD_LOGIC:= '0';
           Next_Address : out STD_LOGIC_VECTOR (2 downto 0));
end MUX_2_to_1_3bit;

architecture Behavioral of MUX_2_to_1_3bit is

COMPONENT TriStateBuffer_3bit
    Port ( In_3 : in STD_LOGIC_VECTOR;
           Out_3 : out STD_LOGIC_VECTOR;
           En_3 : in STD_LOGIC );
END COMPONENT;

SIGNAL flag0, flag1 : STD_LOGIC;

begin
    
    flag0 <= NOT(Jump_Flag);
    flag1 <= Jump_Flag;
    
    TriStateBuffer_0 : TriStateBuffer_3bit
        port map( In_3 => Incremented_Address,
                  Out_3 => Next_Address,
                  En_3 => flag0
        );
    
    TriStateBuffer_1 : TriStateBuffer_3bit
        port map( In_3 => Address_to_Jump,
                  Out_3 => Next_Address,
                  En_3 => flag1
        );

end Behavioral;
