---------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S : out STD_LOGIC;
           C_out : out STD_LOGIC);
end FA;

architecture Behavioral of FA is

component HA   
        port (   
        A: in STD_LOGIC;   
        B: in STD_LOGIC;   
        S: out STD_LOGIC; 
        C: out STD_LOGIC);   
end component;
    
SIGNAL HA0_S, HA0_C, HA1_S, HA1_C : STD_LOGIC;

begin
    HA_0 : HA   
        port map (   
        A => A,   
        B => B,   
        S => HA0_S,   
        C => HA0_C);  
 
    HA_1 : HA   
        port map (   
        A => HA0_S,   
        B => C_in,   
        S => HA1_S,   
        C => HA1_C);
        
        
    C_out <= HA0_C or HA1_C;
    S <= C_in xor HA0_S;


end Behavioral;
