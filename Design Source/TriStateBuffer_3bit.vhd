----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2024 08:53:06 PM
-- Design Name: 
-- Module Name: TriStateBuffer_3bit - Behavioral
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

entity TriStateBuffer_3bit is
    Port ( In_3 : in STD_LOGIC_VECTOR (2 downto 0);
           Out_3 : out STD_LOGIC_VECTOR (2 downto 0);
           En_3 : in STD_LOGIC);
end TriStateBuffer_3bit;

architecture Behavioral of TriStateBuffer_3bit is

begin
    process (In_3,En_3) begin
        if En_3 = '1' then
            Out_3 <= In_3;   -- Pass the input to the output when enabled
        else
            Out_3 <= "ZZZ";  -- Set output to high impedance when disabled
        end if;
    end process;

end Behavioral;
