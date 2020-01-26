---------------------------------------------------------------------------------------------
--    sig_fct_2.vhd   (temporaire)
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
--    Description comportementale
---------------------------------------------------------------------------------------------
entity sig_fct_2 is
    Port (  
    i_ech       : in   std_logic_vector (23 downto 0);
    o_ech_fct   : out  std_logic_vector (23 downto 0)                                    
    );
end sig_fct_2;

---------------------------------------------------------------------------------------------

architecture Behavioral of sig_fct_2 is

---------------------------------------------------------------------------------------------
-- Signaux
---------------------------------------------------------------------------------------------

    CONSTANT Vs : std_logic_vector(21 downto 0) := "1111111111111111111111";
    
    SIGNAL C0 : std_logic_vector(23 downto 0);
    SIGNAL C1 : std_logic_vector(23 downto 0);
    SIGNAL C2 : std_logic_vector(26 downto 0);
    SIGNAL signed_C2 : signed;
    SIGNAL C3 : std_logic_vector(26 downto 0);
    SIGNAL C4 : std_logic_vector(23 downto 0);
    
---------------------------------------------------------------------------------------------
-- 
begin 

    process(i_ech)
    begin
        IF abs(to_integer(signed(i_ech))) < Vs then
            o_ech_fct <= i_ech;
        else
            C0 <= i_ech;
            o_ech_fct <= C4(23) & '0' & Vs;
        end if;
    end process;
    
    pre_gprocess: Process(C0)
    begin
        C1 <= abs(to_integer(signed(i_ech))) - Vs;
    end process;
    
    gprocess: Process(C1)
    begin
        C2 <= C1 & "000";
        signed_c2 <= signed(C2);
        C3 <= Std_Logic_Vector(signed_c2 - ((signed_c2*signed_c2*signed_c2)/3) 
                                + ((signed_c2*signed_c2*signed_c2*signed_c2*signed_c2)/5) 
                                - ((signed_c2*signed_c2*signed_c2*signed_c2*signed_c2*signed_c2*signed_c2)/7));
        C4 <= C3(26 downto 2);
    end process;
        
end Behavioral;  
                 
