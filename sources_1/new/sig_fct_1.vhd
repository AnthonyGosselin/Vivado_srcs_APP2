---------------------------------------------------------------------------------------------
--    sig_fct_1.vhd   (temporaire)
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--    Université de Sherbrooke - Département de GEGI
--
--    Version         : 5.0
--    Nomenclature    : inspiree de la nomenclature 0.2 GRAMS
--    Date            : 29 janvier 2019
--    Auteur(s)       : 
--    Technologie     : ZYNQ 7000 Zybo Z7-10 (xc7z010clg400-1) 
--    Outils          : vivado 2018.2 64 bits
--
---------------------------------------------------------------------------------------------
--  Description 
--  fonction temporaire, aucun calcul
---------------------------------------------------------------------------------------------
--
---------------------------------------------------------------------------------------------
--   À FAIRE:
--   Voir le guide de la problématique
---------------------------------------------------------------------------------------------
--
---------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
USE ieee.numeric_std.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

---------------------------------------------------------------------------------------------
--      FONCTION DISTORTION DURE
---------------------------------------------------------------------------------------------
entity sig_fct_1 is
    Port (  
    i_ech       : in   std_logic_vector (23 downto 0);
    o_ech_fct   : out  std_logic_vector (23 downto 0)                                    
    );
end sig_fct_1;

---------------------------------------------------------------------------------------------

architecture Behavioral of sig_fct_1 is

---------------------------------------------------------------------------------
-- Signaux
----------------------------------------------------------------------------------
    
    CONSTANT Vs : std_logic_vector(21 downto 0) := "1111111111111111111111";
    CONSTANT VSComp : integer := abs(to_integer(unsigned(Vs)));
    SIGNAL output : std_logic_vector(23 downto 0);
    SIGNAL absolute : integer := abs(to_integer(unsigned(i_ech)));
    
---------------------------------------------------------------------------------------------
--    Description comportementale
---------------------------------------------------------------------------------------------
begin 

    absolute <= abs(to_integer(unsigned(i_ech)));

    process(i_ech)
    begin
        IF absolute < VsComp then
            output <= i_ech;
        elsif i_ech(23) = '0' then
            output <= "001111111111111111111111";
        elsif absolute = 0 then
            output <= "000000000000000000000000";
        else
            output <= "110000000000000000000001";
        end if;
    end process;
    
    o_ech_fct <= output;

--    o_ech_fct <= i_ech when abs(to_integer(signed(i_ech))) < Vs
--              else i_ech(23) & '0' & Vs when i_ech(23) = '0'
--              else i_ech(23) & "10000000000000000000001";
    
end Behavioral;
