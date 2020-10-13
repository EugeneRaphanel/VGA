Library IEEE;
use IEEE.STD_Logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity VGAdrive is
  port( clock            : in std_logic;  --50 Mhz clock
        red, green, blue : in std_logic;  -- input values for RGB signals
        row, column : out std_logic_vector(9 downto 0); -- for current pixel
        Rout, Gout, Bout, H, V : out std_logic); -- VGA drive signals
  -- The signals Rout, Gout, Bout, H and V are output to the monitor.
  -- The row and column outputs are used to know when to assert red,
  -- green and blue to color the current pixel.  For VGA, the column
  -- values that are valid are from 0 to 639, all other values should
  -- be ignored.  The row values that are valid are from 0 to 479 and
  -- again, all other values are ignored.  To turn on a pixel on the
  -- VGA monitor, some combination of red, green and blue should be
  -- asserted before the rising edge of the clock.  Objects which are
  -- displayed on the monitor, assert their combination of red, green and
  -- blue when they detect the row and column values are within their
  -- range.  For multiple objects sharing a screen, they must be combined
  -- using logic to create single red, green, and blue signals.
end;

architecture behaviour1 of VGAdrive is
 -- constant freq : natural := 50000000;

  --Signaux de synchronisation Horizontaux définis pour 600*800 72Mhz
  constant HAV : natural := 800;
  constant HFP : natural := 56;
  constant HSync : natural := 120;
  constant HBP : natural := 60;
  constant HTOT : natural :=  HAV+HFP+HSync+HBP;

  --Signaux de synchronisation Verticaux
  constant VAV : natural := 600*800;
  constant VFP : natural := 376*800;
  constant VSync : natural := 6*800;
  constant VBP : natural := 23*800;
  constant VTOT : natural :=  VAV+VFP+VSync+VBP;

  begin


  Rout <= red;
  Gout <= green;
  Bout <= blue;

  process
	variable counter : std_logic_vector (9 downto 0); 
	variable vertical : std_logic_vector (9 downto 0); 
	variable horizontal : std_logic_vector (9 downto 0); 
    begin

    -- increment counters
        if  horizontal < HTOT - 1  then
          horizontal := horizontal + 1;
        else
          horizontal := (others => '0');

          if  vertical < VTOT  then -- less than oh
            vertical := vertical + 1;
          else
            vertical := (others => '0');       -- is set to zero
          end if;
        end if;

    -- define H pulse
        if  horizontal >= (HAV +HFP)  and  horizontal < (HAV +HFP+HSync)  then
          H <= '0';
        else
          H <= '1';
        end if;

    -- define V pulse
        if  (vertical >= ((VAV+VFP))  and  (vertical < (VAV +VFP+VSync))) then
          V <= '0';
        else
          V <= '1';
        end if;

        row <= vertical;
        column <= horizontal;

      end process;

    end architecture;