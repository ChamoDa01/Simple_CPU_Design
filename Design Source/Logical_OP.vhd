----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2024 08:22:37 PM
-- Design Name: 
-- Module Name: Logical_OP - Behavioral
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

entity Logical_OP is
    Port ( IN_A : in STD_LOGIC_VECTOR (3 downto 0);
           IN_B : in STD_LOGIC_VECTOR (3 downto 0);
           Func_Sel : in STD_LOGIC_VECTOR (1 downto 0);
           Result : out STD_LOGIC_VECTOR (3 downto 0));
end Logical_OP;

architecture Behavioral of Logical_OP is

COMPONENT Decoder_2_to_4
    PORT( I : in STD_LOGIC_VECTOR;
          En : in STD_LOGIC;
          Y : out STD_LOGIC_VECTOR );
END COMPONENT;

COMPONENT TriStateBuffer
    Port ( Input : in STD_LOGIC_VECTOR;
           Output : out STD_LOGIC_VECTOR;
           Enable : in STD_LOGIC );
END COMPONENT;

Signal Q1,Q2,Q3,Q4,Decoder_Out : STD_LOGIC_VECTOR(3 downto 0);

begin
    Decoder_2_to_4_0 : Decoder_2_to_4
    port map( I =>  Func_Sel,
              EN => '1',
              Y => Decoder_Out
    );
    
    -- A AND B
    Q1(0) <= IN_A(0) and IN_B(0);
    Q1(1) <= IN_A(1) and IN_B(1);
    Q1(2) <= IN_A(2) and IN_B(2);
    Q1(3) <= IN_A(3) and IN_B(3);
    
    -- A OR B 
    Q2(0) <= IN_A(0) or IN_B(0);
    Q2(1) <= IN_A(1) or IN_B(1);
    Q2(2) <= IN_A(2) or IN_B(2);
    Q2(3) <= IN_A(3) or IN_B(3);
    
    -- NOT A
    Q3(0) <= not IN_A(0);
    Q3(1) <= not IN_A(1);
    Q3(2) <= not IN_A(2);
    Q3(3) <= not IN_A(3);
        
    -- Arithmetic Right Shift A (A/2)
    -- for (-8 to 7)
    Q4(0) <= IN_A(1);
    Q4(1) <= IN_A(2);
    Q4(2) <= IN_A(3);
    Q4(3) <= IN_A(3);
    
    TriStateBuffer_0 : TriStateBuffer
    Port map ( Input => Q1,
               Output => Result,
               Enable => Decoder_Out(0)
    );
    
    TriStateBuffer_1 : TriStateBuffer
    Port map ( Input => Q2,
               Output => Result,
               Enable => Decoder_Out(1)
    );
    
    TriStateBuffer_2 : TriStateBuffer
    Port map ( Input => Q3,
               Output => Result,
               Enable => Decoder_Out(2)
    );
    
    TriStateBuffer_3 : TriStateBuffer
    Port map ( Input => Q4,
               Output => Result,
               Enable => Decoder_Out(3)
    );
    
end Behavioral;
