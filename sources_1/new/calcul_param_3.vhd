
---------------------------------------------------------------------------------------------
--    calcul_param_3.vhd   (temporaire)
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--    Universit� de Sherbrooke - D�partement de GEGI
--
--    Version         : 5.0
--    Nomenclature    : inspiree de la nomenclature 0.2 GRAMS
--    Date            : 16 janvier 2020
--    Auteur(s)       : 
--    Technologie     : ZYNQ 7000 Zybo Z7-10 (xc7z010clg400-1) 
--    Outils          : vivado 2019.1 64 bits
--
---------------------------------------------------------------------------------------------
--    Description (sur une carte Zybo)
---------------------------------------------------------------------------------------------
--
---------------------------------------------------------------------------------------------
-- � FAIRE: 
-- Voir le guide de la probl�matique
---------------------------------------------------------------------------------------------
--
---------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  -- pour les additions dans les compteurs
USE ieee.numeric_std.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

----------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------
entity calcul_param_3 is
    Port (
    i_bclk    : in   std_logic;   -- bit clock
    i_reset   : in   std_logic;
    i_en      : in   std_logic;   -- un echantillon present
    i_lrc     : in   std_logic;   
    i_ech     : in   std_logic_vector (23 downto 0);
    o_param   : out  std_logic_vector (7 downto 0)                                     
    );
end calcul_param_3;

----------------------------------------------------------------------------------

architecture Behavioral of calcul_param_3 is

component compteur_nbits 
generic (nbits : integer := 7);
   port ( clk             : in    std_logic; 
          i_en            : in    std_logic; 
          reset           : in    std_logic; 
          o_val_cpt       : out   std_logic_vector (nbits-1 downto 0)
          );
end component;

component reg_nbits
generic (nbits : integer := 24); 
  Port ( 
    i_clk       : in std_logic;
    i_reset     : in std_logic;
    i_en        : in std_logic;
    i_dat       : in std_logic_vector(nbits-1 downto 0);
    o_dat       : out  std_logic_vector(nbits-1 downto 0)
);
end component;

component fifo is
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
end component;

component MEF_param3 is
    Port ( i_bclk      : in std_logic;
       i_rst : in STD_LOGIC;
       i_dat : in STD_LOGIC_VECTOR (23 downto 0);
       i_cmp_dat : in STD_LOGIC_VECTOR (23 downto 0);
       i_cnt : in STD_LOGIC_VECTOR (6 downto 0);
       i_start : STD_LOGIC;
       o_rst_cnt : out STD_LOGIC;
       o_enable_cnt : out STD_LOGIC;
       o_write_cmp_reg : out STD_LOGIC;
       o_write_o_reg : out STD_LOGIC);
end component;

---------------------------------------------------------------------------------
-- Signaux
----------------------------------------------------------------------------------

signal enable_cnt : std_logic;
signal rst_cnt : std_logic;
signal write_cmp : std_logic;
signal write_o : std_logic;
signal cnt : std_logic_vector (6 downto 0);
signal cmp_reg : std_logic_vector (23 downto 0);
signal o_reg : std_logic_vector (23 downto 0);
signal o_fifo : std_logic_vector (23 downto 0);

---------------------------------------------------------------------------------------------
--    Description comportementale
---------------------------------------------------------------------------------------------
begin 

inst_mef : MEF_param3
    Port map ( i_bclk => i_bclk,
       i_rst => i_reset,
       i_dat => o_fifo,
       i_cmp_dat => cmp_reg,
       i_cnt => cnt,
       i_start => i_en,        -- to change to enable when fifo write
       o_rst_cnt => rst_cnt,
       o_enable_cnt => enable_cnt,
       o_write_cmp_reg => write_cmp,
       o_write_o_reg => write_o);

inst_fifo : fifo
         generic map (
           g_width => 24,
           g_depth => 48
           )
         port map (
           i_rst_async => i_reset,
           i_clk      => i_bclk,
            
           -- FIFO Write Interface
           i_wr_en   => i_en,
           i_wr_data => i_ech,
           o_full    => open,
           
           -- FIFO Read Interface
           i_rd_en   => enable_cnt,
           o_rd_data => o_fifo,
           o_empty   => open
           );

inst_cpt_bits : compteur_nbits
generic map (nbits => 7)
port  map
 ( clk        => i_bclk,
  i_en        => enable_cnt,
  reset       => rst_cnt,
  o_val_cpt   => cnt
  );

compare_reg : reg_nbits
  generic map (nbits => 24) 
    Port map ( 
      i_clk       => i_bclk,
      i_reset     => i_reset,
      i_en        => write_cmp,
      i_dat       => o_fifo,
      o_dat       => cmp_reg
  );

out_reg : reg_nbits
    generic map (nbits => 24) 
      Port map ( 
        i_clk       => i_bclk,
        i_reset     => i_reset,
        i_en        => write_o,
        i_dat       => cmp_reg,
        o_dat       => o_reg
    );


     o_param <= o_reg (23 downto 16);

 
end Behavioral;
