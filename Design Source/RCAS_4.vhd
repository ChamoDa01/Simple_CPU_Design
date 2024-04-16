----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2024 20:19:58
-- Design Name: 
-- Module Name: Adder_Subtractor - Behavioral
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

entity RCAS_4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (3 downto 0);
           M : in STD_LOGIC;
           Carry : out STD_LOGIC;
           Overflow : out STD_LOGIC );
end RCAS_4;

architecture Behavioral of RCAS_4 is

signal temp : std_logic_vector(3 downto 0); -- Intermediate signal of changed input B for operation Subtract
signal c : std_logic_vector(4 downto 0); -- Carry Out Signals Bus

component FA 
    port ( A: in std_logic;
           B: in std_logic;
           C_in: in std_logic;
           S: out std_logic;
           C_out: out std_logic);
end component;

begin

    c(0) <= M;
    temp(0) <= B(0) xor M;
    temp(1) <= B(1) xor M;
    temp(2) <= B(2) xor M;
    temp(3) <= B(3) xor M;

    FA_0 : FA
    port map ( A => A(0),
               B => temp(0),
               C_in => M,
               S => S(0),
               C_Out => c(1));

    FA_1 : FA
    port map ( A => A(1),
               B => temp(1),
               C_in => c(1),
               S => S(1),
               C_Out => c(2));

    FA_2 : FA
    port map ( A => A(2),
               B => temp(2),
               C_in => c(2),
               S => S(2),
               C_Out => c(3));

    FA_3 : FA
    port map ( A => A(3),
               B => temp(3),
               C_in => c(3),
               S => S(3),
               C_Out => c(4));

    carry <= c(4);
    Overflow <= c(4) xor c(3);
    
end Behavioral;
