---------------------------------------------------------------------------------------------
--    sig_fct_1.vhd   (temporaire)
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--    Universit� de Sherbrooke - D�partement de GEGI
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
--   � FAIRE:
--   Voir le guide de la probl�matique
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
    CONSTANT MaxVal : std_logic_vector(23 downto 0) := "111111111111111111111111";
    CONSTANT Vs : std_logic_vector(21 downto 0) := MaxVal(23 downto 2);
    CONSTANT VSComp : integer := to_integer(unsigned(Vs));
    SIGNAL output : std_logic_vector(23 downto 0);
    SIGNAL absolute : integer := abs(to_integer(unsigned(i_ech)));
    
---------------------------------------------------------------------------------------------
--    Description comportementale
---------------------------------------------------------------------------------------------
begin 

    process(i_ech)
    begin
        absolute <= abs(to_integer(unsigned(i_ech)));
    
        IF absolute < VsComp then
            output <= i_ech;
        elsif i_ech(23) = '0' then
            output <= "00" & Vs;
        elsif absolute = 0 then
            output <= "000000000000000000000000";
        else
            output <= "110000000000000000000001";
        end if;
    end process;
    
    o_ech_fct <= output;
    
end Behavioral;
