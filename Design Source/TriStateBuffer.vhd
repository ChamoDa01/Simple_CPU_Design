----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 11:18:29 AM
-- Design Name: 
-- Module Name: TriStateBuffer - Behavioral
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

entity TriStateBuffer is
    Port ( Input : in STD_LOGIC_VECTOR (3 downto 0);
           Output : out STD_LOGIC_VECTOR (3 downto 0);
           Enable : in STD_LOGIC);
end TriStateBuffer;

architecture Behavioral of TriStateBuffer is

begin
    process (Input,Enable) begin
        if Enable = '1' then
            Output <= Input;   -- Pass the input to the output when enabled
        else
            Output <= "ZZZZ";  -- Set output to high impedance when disabled
        end if;
    end process;

end Behavioral;
