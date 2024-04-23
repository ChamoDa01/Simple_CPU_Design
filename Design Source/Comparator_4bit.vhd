----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2024 15:11:59
-- Design Name: 
-- Module Name: Comparator_4bit - Behavioral
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

entity Comparator_4bit is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           G_out : out STD_LOGIC;
           S_out : out STD_LOGIC;
           E_out : out STD_LOGIC);
end Comparator_4bit;

architecture Behavioral of Comparator_4bit is

component Comparator_1bit
    Port ( G_in : in STD_LOGIC;
    	   S_in : in STD_LOGIC;
           E_in : in STD_LOGIC;
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           G_out : out STD_LOGIC;
           S_out : out STD_LOGIC;
           E_out : out STD_LOGIC);
end component;

signal G_out_0,S_out_0,E_out_0,G_out_1,S_out_1,E_out_1,G_out_2,S_out_2,E_out_2,G_out_3,S_out_3,E_out_3: std_logic;

begin

	Comparator_0: Comparator_1bit
    	port map( G_in => '0',
        	  S_in => '0',
                  E_in => '1',
                  A => A(3),
                  B => B(3),
                  G_out => G_out_0,
                  S_out => S_out_0,
                  E_out => E_out_0
        );
    
    Comparator_1: Comparator_1bit
    	port map( G_in => G_out_0,
        	  S_in => S_out_0,
                  E_in => E_out_0,
                  A => A(2),
                  B => B(2),
                  G_out => G_out_1,
                  S_out => S_out_1,
                  E_out => E_out_1
        );
    
    Comparator_2: Comparator_1bit
    	port map( G_in => G_out_1,
        	  S_in => S_out_1,
                  E_in => E_out_1,
                  A => A(1),
                  B => B(1),
                  G_out => G_out_2,
                  S_out => S_out_2,
                  E_out => E_out_2
        );
    
    Comparator_3: Comparator_1bit
    	port map( G_in => G_out_2,
        	  S_in => S_out_2,
                  E_in => E_out_2,
                  A => A(0),
                  B => B(0),
                  G_out => G_out_3,
                  S_out => S_out_3,
                  E_out => E_out_3
        );
        
    G_out <= G_out_3;
    S_out <= S_out_3;
    E_out <= E_out_3;

end Behavioral;
