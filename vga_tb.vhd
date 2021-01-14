-- RGB VGA test pattern  Rob Chapman  Mar 9, 1998

 -- This file uses the VGA driver and creates 3 squares on the screen which
 -- show all the available colors from mixing red, green and blue

Library IEEE;
use IEEE.STD_Logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use std.textio.all; -- Imports the standard textio package.

entity vga_tb is
end entity;

architecture test of vga_tb is

  component vgadrive is
    port( clock          : in std_logic;  -- 25.175 Mhz clock
        red, green, blue : in std_logic;  -- input values for RGB signals
        row, column      : out std_logic_vector(9 downto 0); -- for current pixel
        Rout, Gout, Bout, H, V : out std_logic); -- VGA drive signals
  end component;
  
  signal row, column : std_logic_vector(9 downto 0) := (others => '0');
  signal red, green, blue : std_logic:= '0';
  signal clock : std_logic := '0';
  signal Rout, Gout, Bout,H,V : std_logic:='0';
  constant half_period:time := 4 ns;
  
	begin  
	
  -- for debugging: to view the bit order
  VGA : component vgadrive
    port map ( clock => clock, red => red, green => green, blue => blue,
               row => row, column => column,
               Rout => Rout, Gout => Gout, Bout => Bout, H => H, V => V);
 
  
 --process begin
   --     clock <= not clock after half_period;
    --end process;
    
 process 
 	variable l : line;
 	begin 
 		write (l, String'("Hello world!"));
    		writeline (output, l);
  	      row <= row +1;
        	column <= column +1;
        	red <= '1';
        	clock <= '1' after 2 ns;
        	write (l, String'("after 2 ns"));
    		writeline (output, l);
        	red <='0' after 1 ns ;
        	clock <= '0' after 2 ns;
        	write (l, String'("fin"));
    		writeline (output, l);
        	wait;
	end process;
	
end architecture;
