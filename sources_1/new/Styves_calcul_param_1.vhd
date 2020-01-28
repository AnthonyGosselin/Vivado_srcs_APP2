
---------------------------------------------------------------------------------------------
--    calcul_param_1.vhd   (temporaire)
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
entity calcul_param_1 is
    Port (
    i_bclk    : in   std_logic; -- bit clock (I2S)
    i_reset   : in   std_logic;
    i_en      : in   std_logic; -- un echantillon present a l'entr�e
    i_lrc     : in   std_logic; -- signal horloge echantilonnage gauche-droite (I2S)
    i_ech     : in   std_logic_vector (23 downto 0); -- echantillon en entr�e
    o_param   : out  std_logic_vector (7 downto 0)   -- param�tre calcul�
    );
end calcul_param_1;

----------------------------------------------------------------------------------

architecture Behavioral of calcul_param_1 is

component MEF_param1 is
    Port ( i_bclk      : in std_logic;
           i_en : std_logic;
           i_rst : in STD_LOGIC;
           i_sign : in STD_LOGIC;
           o_rst_cnt : out STD_LOGIC;
           o_enable : out STD_LOGIC;
           o_write_reg : out STD_LOGIC);
end component;

component compteur_nbits 
generic (nbits : integer := 12);
   port ( clk             : in    std_logic; 
          i_en            : in    std_logic; 
          reset           : in    std_logic; 
          o_val_cpt       : out   std_logic_vector (nbits-1 downto 0)
          );
end component;

component reg_nbits
generic (nbits : integer := 12); 
  Port ( 
    i_clk       : in std_logic;
    i_reset     : in std_logic;
    i_en        : in std_logic;
    i_dat       : in std_logic_vector(nbits-1 downto 0);
    o_dat       : out  std_logic_vector(nbits-1 downto 0)
);
end component;

---------------------------------------------------------------------------------
-- Signaux
----------------------------------------------------------------------------------
--signal enable_cnt : std_logic;
signal rst_cnt : std_logic;
signal enable_write : std_logic;
signal cnt : std_logic_vector (11 downto 0);
signal o_reg : std_logic_vector (11 downto 0);

---------------------------------------------------------------------------------------------
--    Description comportementale
---------------------------------------------------------------------------------------------
begin 

inst_MEF : MEF_param1
    Port map
         ( i_bclk   => i_bclk,
           i_en => i_en,
           i_rst => i_reset,
           i_sign => i_ech(23),
           o_rst_cnt => rst_cnt,
           o_enable => open,
           o_write_reg => enable_write
           );

inst_cpt_bits : compteur_nbits
generic map (nbits => 12)
port  map
 ( clk        => i_bclk,
  i_en        => 1,     -- compteur toujours actif
  reset       => rst_cnt,
  o_val_cpt   => cnt
  );

inst_reg : reg_nbits
  generic map (nbits => 12) 
    Port map ( 
      i_clk       => i_bclk,
      i_reset     => i_reset,
      i_en        => enable_write,
      i_dat       => cnt,
      o_dat       => o_reg
  );

     o_param <= o_reg (7 downto 0);
 
end Behavioral;
