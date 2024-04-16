----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2024 05:35:03 PM
-- Design Name: 
-- Module Name: RegBank - Behavioral
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

entity RegBank is
    Port ( Value : in STD_LOGIC_VECTOR (3 downto 0);
           Clk : in STD_LOGIC;
           RegEN : in STD_LOGIC_VECTOR (2 downto 0);
           Reset : in STD_LOGIC;
           Q0 : out STD_LOGIC_VECTOR (3 downto 0);
           Q1 : out STD_LOGIC_VECTOR (3 downto 0);
           Q2 : out STD_LOGIC_VECTOR (3 downto 0);
           Q3 : out STD_LOGIC_VECTOR (3 downto 0);
           Q4 : out STD_LOGIC_VECTOR (3 downto 0);
           Q5 : out STD_LOGIC_VECTOR (3 downto 0);
           Q6 : out STD_LOGIC_VECTOR (3 downto 0);
           Q7 : out STD_LOGIC_VECTOR (3 downto 0));
end RegBank;

architecture Behavioral of RegBank is

COMPONENT Reg
    Port ( D : in STD_LOGIC_VECTOR;
           EN : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR);

END COMPONENT;

COMPONENT Decoder_3_to_8
    Port ( I : in STD_LOGIC_VECTOR;
           En : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR);
END COMPONENT;

SIGNAL decoderOut : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL reg_0_en : STD_LOGIC;

begin

    Decoder_3_to_8_0 : Decoder_3_to_8
    Port map ( I => RegEN,
               En => '1', -- decoder is always enable 
               Y => decoderOut
    );
    
    Reg_0 : Reg -- R0 is a read-only register
    Port map ( D => Value,
               EN => '0',
               Clk => Clk,
               Reset => Reset,
               Q => Q0 
    );
    
    Reg_1 : Reg
    Port map ( D => Value,
               EN => decoderOut(1),
               Clk => Clk,
               Reset => Reset,
               Q => Q1
    );
    
    Reg_2 : Reg
    Port map ( D => Value,
               EN => decoderOut(2),
               Clk => Clk,
               Reset => Reset,
               Q => Q2 
    );
        
    Reg_3 : Reg
    Port map ( D => Value,
               EN => decoderOut(3),
               Clk => Clk,
               Reset => Reset,
               Q => Q3 
    );
    
    Reg_4 : Reg
    Port map ( D => Value,
               EN => decoderOut(4),
               Clk => Clk,
               Reset => Reset,
               Q => Q4 
    );
    
    Reg_5 : Reg
    Port map ( D => Value,
               EN => decoderOut(5),
               Clk => Clk,
               Reset => Reset,
               Q => Q5 
    );
    
    Reg_6 : Reg
    Port map ( D => Value,
               EN => decoderOut(6),
               Clk => Clk,
               Reset => Reset,
               Q => Q6 
    );
    
    reg_0_en <= not(decoderOut(0));
    Reg_7 : Reg
    Port map ( D => Value,
               EN => reg_0_en, -- always result is stored in R7
               Clk => Clk,
               Reset => Reset,
               Q => Q7 
    );
    
end Behavioral;
