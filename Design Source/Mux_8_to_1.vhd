----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2024 11:00:39 PM
-- Design Name: 
-- Module Name: Mux_8_to_1 - Behavioral
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

entity Mux_8_to_1 is
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
end Mux_8_to_1;

architecture Behavioral of Mux_8_to_1 is

COMPONENT Decoder_3_to_8
    Port ( I : in STD_LOGIC_VECTOR;
           En : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR);
END COMPONENT;

COMPONENT TriStateBuffer
    Port ( Input : in STD_LOGIC_VECTOR;
           Output : out STD_LOGIC_VECTOR;
           Enable : in STD_LOGIC );
END COMPONENT;

SIGNAL decoderOut : STD_LOGIC_VECTOR(7 downto 0);

begin

    Decoder_3_to_8_0 : Decoder_3_to_8
    Port map ( I => RegSel,
               En => '1', -- decoder is always enable 
               Y => decoderOut
    );
    
    TriStateBuffer_0 : TriStateBuffer
    Port map ( Input => muxIN0,
               Output => muxOut,
               Enable => decoderOut(0)
    );
    
    TriStateBuffer_1 : TriStateBuffer
    Port map ( Input => muxIN1,
               Output => muxOut,
               Enable => decoderOut(1)
    );
    
    TriStateBuffer_2 : TriStateBuffer
    Port map ( Input => muxIN2,
               Output => muxOut,
               Enable => decoderOut(2)
    );
    
    TriStateBuffer_3 : TriStateBuffer
    Port map ( Input => muxIN3,
               Output => muxOut,
               Enable => decoderOut(3)
    );
    
    TriStateBuffer_4 : TriStateBuffer
    Port map ( Input => muxIN4,
               Output => muxOut,
               Enable => decoderOut(4)
    );
    
    TriStateBuffer_5 : TriStateBuffer
    Port map ( Input => muxIN5,
               Output => muxOut,
               Enable => decoderOut(5)
    );
    
    TriStateBuffer_6 : TriStateBuffer
    Port map ( Input => muxIN6,
               Output => muxOut,
               Enable => decoderOut(6)
    );
    
    TriStateBuffer_7 : TriStateBuffer
    Port map ( Input => muxIN7,
               Output => muxOut,
               Enable => decoderOut(7)
    );  

end Behavioral;
