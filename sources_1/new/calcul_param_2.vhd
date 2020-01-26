
---------------------------------------------------------------------------------------------
--    calcul_param_2.vhd   (temporaire)
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
--use IEEE.STD_LOGIC_UNSIGNED.ALL;  -- pour les additions dans les compteurs
USE ieee.numeric_std.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

----------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------
entity calcul_param_2 is
    Port (
    i_bclk    : in   std_logic;   -- bit clock
    i_reset   : in   std_logic;
    i_en      : in   std_logic;   -- un echantillon present
    i_lrc     : in   std_logic;   
    i_ech     : in   std_logic_vector (23 downto 0);
    o_param   : out  std_logic_vector (7 downto 0)                                     
    );
end calcul_param_2;

----------------------------------------------------------------------------------

architecture Behavioral of calcul_param_2 is

---------------------------------------------------------------------------------
-- Signaux
----------------------------------------------------------------------------------

signal curr_sqr_sum : unsigned(48 downto 0) := (others => '0');
signal sqr_fact_val : unsigned(48 downto 0);

signal ech_int : integer;
signal sqr_val_int : integer;
signal sqr_val_float : natural;
signal sqr_fact_val_float : natural;
signal curr_sum_float : natural;
---------------------------------------------------------------------------------------------
--    Description comportementale
---------------------------------------------------------------------------------------------
begin 
    
    process(i_reset, i_bclk)
    begin
        if i_reset = '1' then
            o_param <= (others => '0');
        end if;
        if i_bclk = '1' and i_bclk'event then
            --curr_sqr_sum <= i_ech + curr_sqr_sum;
            ech_int <= to_integer(signed(i_ech));
            sqr_val_int <= ech_int * ech_int;
            sqr_val_float <= natural(sqr_val_int);
            sqr_fact_val_float <= (sqr_val_float * 31)/32;
            curr_sum_float <= curr_sum_float + sqr_fact_val_float;
            
            
        end if;
    end process;
     --o_param <= x"02";    -- temporaire ...

end Behavioral;
