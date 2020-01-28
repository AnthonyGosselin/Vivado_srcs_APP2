----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2020 02:09:25 PM
-- Design Name: 
-- Module Name: fifo - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo is
  generic (
    g_width : natural := 24;
    g_depth : integer := 48
    );
    
  port (
    i_rst_async : in std_logic;
    i_clk      : in std_logic;
     
    -- FIFO Write Interface
    i_wr_en   : in  std_logic;
    i_wr_data : in  std_logic_vector(g_WIDTH-1 downto 0);
    o_full    : out std_logic; -- to remove
    
    -- FIFO Read Interface
    i_rd_en   : in  std_logic;
    o_rd_data : out std_logic_vector(g_WIDTH-1 downto 0);
    o_empty   : out std_logic -- to remove
    );
end fifo;

architecture Behavioral of fifo is

type t_FIFO_DATA is array (0 to g_DEPTH-1) of std_logic_vector(g_WIDTH-1 downto 0);
signal r_FIFO_DATA : t_FIFO_DATA := (others => (others => '0'));

signal r_WR_INDEX   : integer range 0 to g_DEPTH-1 := 0;
signal r_RD_INDEX   : integer range 0 to g_DEPTH-1 := 0;

-- # Words in FIFO, has extra range to allow for assert conditions
signal r_FIFO_COUNT : integer range 0 to g_DEPTH-1 := 0;

signal w_FULL  : std_logic;
signal w_EMPTY : std_logic;


begin

  p_CONTROL : process (i_clk) is
begin
  if i_rst_async = '1' then
    r_FIFO_COUNT <= 0;
    r_WR_INDEX   <= 0;
    r_RD_INDEX   <= 0;
  else
  if rising_edge(i_clk) then

      -- Keeps track of the total number of words in the FIFO
      if (i_wr_en = '1' and i_rd_en = '0') then
        r_FIFO_COUNT <= r_FIFO_COUNT + 1;
      elsif (i_wr_en = '0' and i_rd_en = '1') then
        r_FIFO_COUNT <= r_FIFO_COUNT - 1;
      end if;

      -- Keeps track of the write index (and controls roll-over)
      if (i_wr_en = '1') then
        if r_WR_INDEX = g_DEPTH-1 then
          r_WR_INDEX <= 0;
        else
          r_WR_INDEX <= r_WR_INDEX + 1;
        end if;
      end if;

      -- Keeps track of the read index (and controls roll-over)        
      if (i_rd_en = '1') then
        if r_RD_INDEX = g_DEPTH-1 then
          r_RD_INDEX <= 0;
        else
          r_RD_INDEX <= r_RD_INDEX + 1;
        end if;
      end if;

      -- Registers the input data when there is a write
      if i_wr_en = '1' then
        r_FIFO_DATA(r_WR_INDEX) <= i_wr_data;
      end if;
       
    end if;                           -- sync reset
  end if;                             -- rising_edge(i_clk)
end process p_CONTROL;
 
o_rd_data <= r_FIFO_DATA(r_RD_INDEX);

w_FULL  <= '1' when r_FIFO_COUNT = g_DEPTH else '0';
w_EMPTY <= '1' when r_FIFO_COUNT = 0       else '0';

o_full  <= w_FULL;
o_empty <= w_EMPTY;


end Behavioral;