
---------------------------------------------------------------------------------------------
--    calcul_param_1.vhd   (temporaire)
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--    Université de Sherbrooke - Département de GEGI
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
-- À FAIRE: 
-- Voir le guide de la problématique
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
    i_en      : in   std_logic; -- un echantillon present a l'entrée
    i_lrc     : in   std_logic; -- signal horloge echantilonnage gauche-droite (I2S)
    i_ech     : in   std_logic_vector (23 downto 0); -- echantillon en entrée
    o_param   : out  std_logic_vector (7 downto 0)   -- paramètre calculé
    );
end calcul_param_1;

----------------------------------------------------------------------------------

architecture Behavioral of calcul_param_1 is

---------------------------------------------------------------------------------
-- Signaux
----------------------------------------------------------------------------------
    
Component mef_positif_param1 is
    Port ( i_ech            : in STD_LOGIC_VECTOR(23 downto 0);
           i_bclk           : in std_logic;
           i_reset          : in    std_logic;  
           i_en             : out   std_logic;
           o_cpt_bit_reset  : out std_logic;
           Affirmed         : out std_logic
    );
end Component;

Component compteur_nbits is
generic (nbits : integer := 8);
   port ( clk             : in    std_logic; 
          i_en            : in    std_logic; 
          reset           : in    std_logic; 
          o_val_cpt       : out   std_logic_vector (nbits-1 downto 0)
          );
end Component;

SIGNAL s_Affirmed : STD_LOGIC ;
SIGNAL s_val_cpt : STD_LOGIC_VECTOR(7 downto 0) ;
SIGNAL s_reset : STD_LOGIC ;
SIGNAL s_en : STD_LOGIC ;


CONSTANT f_bclk : integer := 3100000;       -- 3.1 MHz


---------------------------------------------------------------------------------------------
--    Description comportementale
---------------------------------------------------------------------------------------------
begin 

inst_mef_positif_param1: mef_positif_param1
    port map (  i_ech            =>     i_ech,
                i_bclk           =>     i_bclk,
                i_reset          =>     i_reset,                       
                i_en             =>     s_en,                       
                o_cpt_bit_reset  =>     s_reset,
                Affirmed         =>     s_Affirmed
    );
    
inst_cpt_positif_param1: compteur_nbits
    port map (  clk        =>     i_bclk,
                i_en       =>     s_en,
                reset      =>     s_reset,                       
                o_val_cpt  =>     s_val_cpt
    );    
    
    s_reset <= i_reset;

    Aff_process: Process(s_Affirmed)
    begin
        if s_Affirmed = '1' then
            o_param <= STD_LOGIC_VECTOR(f_bclk / unsigned(s_val_cpt));
        end if;
    end process;
 
end Behavioral;
