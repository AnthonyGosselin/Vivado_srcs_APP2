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
    CONSTANT VSComp : integer := to_integer(unsigned(Vs));
    SIGNAL absolute : integer := abs(to_integer(unsigned(i_ech)));
    
---------------------------------------------------------------------------------------------
-- 
begin 

    process(i_ech)
    begin
       absolute <= abs(to_integer(unsigned(i_ech)));
           
        IF absolute < VSComp then o_ech_fct <= i_ech;
        ELSIF (absolute < 2097151) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "000111111111111111111111"; ELSE o_ech_fct <= "111000000000000000000001"; END IF;
        ELSIF (absolute < 2163991) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001000010000010100010111"; ELSE o_ech_fct <= "110111101111101011101001"; END IF;
        ELSIF (absolute < 2230292) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001000100000100000010100"; ELSE o_ech_fct <= "110111011111011111101100"; END IF;
        ELSIF (absolute < 2295541) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001000110000011011110101"; ELSE o_ech_fct <= "110111001111100100001011"; END IF;
        ELSIF (absolute < 2359273) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001000111111111111101001"; ELSE o_ech_fct <= "110111000000000000010111"; END IF;
        ELSIF (absolute < 2421089) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001001001111000101100001"; ELSE o_ech_fct <= "110110110000111010011111"; END IF;
        ELSIF (absolute < 2480665) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001001011101101000011001"; ELSE o_ech_fct <= "110110100010010111100111"; END IF;
        ELSIF (absolute < 2537759) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001001101011100100011111"; ELSE o_ech_fct <= "110110010100011011100001"; END IF;
        ELSIF (absolute < 2592207) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001001111000110111001111"; ELSE o_ech_fct <= "110110000111001000110001"; END IF;
        ELSIF (absolute < 2643915) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001010000101011111001011"; ELSE o_ech_fct <= "110101111010100000110101"; END IF;
        ELSIF (absolute < 2692852) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001010010001011011110100"; ELSE o_ech_fct <= "110101101110100100001100"; END IF;
        ELSIF (absolute < 2739040) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001010011100101101100000"; ELSE o_ech_fct <= "110101100011010010100000"; END IF;
        ELSIF (absolute < 2782538) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001010100111010101001010"; ELSE o_ech_fct <= "110101011000101010110110"; END IF;
        ELSIF (absolute < 2823439) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001010110001010100001111"; ELSE o_ech_fct <= "110101001110101011110001"; END IF;
        ELSIF (absolute < 2861854) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001010111010101100011110"; ELSE o_ech_fct <= "110101000101010011100010"; END IF;
        ELSIF (absolute < 2897909) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001011000011011111110101"; ELSE o_ech_fct <= "110100111100100000001011"; END IF;
        ELSIF (absolute < 2931738) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001011001011110000011010"; ELSE o_ech_fct <= "110100110100001111100110"; END IF;
        ELSIF (absolute < 2963476) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001011010011100000010100"; ELSE o_ech_fct <= "110100101100011111101100"; END IF;
        ELSIF (absolute < 2993258) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001011011010110001101010"; ELSE o_ech_fct <= "110100100101001110010110"; END IF;
        ELSIF (absolute < 3021216) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001011100001100110100000"; ELSE o_ech_fct <= "110100011110011001100000"; END IF;
        ELSIF (absolute < 3047477) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001011101000000000110101"; ELSE o_ech_fct <= "110100010111111111001011"; END IF;
        ELSIF (absolute < 3072159) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001011101110000010011111"; ELSE o_ech_fct <= "110100010001111101100001"; END IF;
        ELSIF (absolute < 3095376) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001011110011101101010000"; ELSE o_ech_fct <= "110100001100010010110000"; END IF;
        ELSIF (absolute < 3117234) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001011111001000010110010"; ELSE o_ech_fct <= "110100000110111101001110"; END IF;
        ELSIF (absolute < 3137832) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001011111110000100101000"; ELSE o_ech_fct <= "110100000001111011011000"; END IF;
        ELSIF (absolute < 3157261) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100000010110100001101"; ELSE o_ech_fct <= "110011111101001011110011"; END IF;
        ELSIF (absolute < 3175605) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100000111010010110101"; ELSE o_ech_fct <= "110011111000101101001011"; END IF;
        ELSIF (absolute < 3192942) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100001011100001101110"; ELSE o_ech_fct <= "110011110100011110010010"; END IF;
        ELSIF (absolute < 3209345) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100001111100010000001"; ELSE o_ech_fct <= "110011110000011101111111"; END IF;
        ELSIF (absolute < 3224879) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100010011010100101111"; ELSE o_ech_fct <= "110011101100101011010001"; END IF;
        ELSIF (absolute < 3239605) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100010110111010110101"; ELSE o_ech_fct <= "110011101001000101001011"; END IF;
        ELSIF (absolute < 3253580) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100011010010101001100"; ELSE o_ech_fct <= "110011100101101010110100"; END IF;
        ELSIF (absolute < 3266855) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100011101100100100111"; ELSE o_ech_fct <= "110011100010011011011001"; END IF;
        ELSIF (absolute < 3279477) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100100000101001110101"; ELSE o_ech_fct <= "110011011111010110001011"; END IF;
        ELSIF (absolute < 3291490) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100100011100101100010"; ELSE o_ech_fct <= "110011011100011010011110"; END IF;
        ELSIF (absolute < 3302934) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100100110011000010110"; ELSE o_ech_fct <= "110011011001100111101010"; END IF;
        ELSIF (absolute < 3313846) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100101001000010110110"; ELSE o_ech_fct <= "110011010110111101001010"; END IF;
        ELSIF (absolute < 3324260) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100101011100101100100"; ELSE o_ech_fct <= "110011010100011010011100"; END IF;
        ELSIF (absolute < 3334207) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100101110000000111111"; ELSE o_ech_fct <= "110011010001111111000001"; END IF;
        ELSIF (absolute < 3343716) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100110000010101100100"; ELSE o_ech_fct <= "110011001111101010011100"; END IF;
        ELSIF (absolute < 3352815) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100110010100011101111"; ELSE o_ech_fct <= "110011001101011100010001"; END IF;
        ELSIF (absolute < 3361528) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100110100101011111000"; ELSE o_ech_fct <= "110011001011010100001000"; END IF;
        ELSIF (absolute < 3369877) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100110110101110010101"; ELSE o_ech_fct <= "110011001001010001101011"; END IF;
        ELSIF (absolute < 3377885) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100111000101011011101"; ELSE o_ech_fct <= "110011000111010100100011"; END IF;
        ELSIF (absolute < 3385571) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100111010100011100011"; ELSE o_ech_fct <= "110011000101011100011101"; END IF;
        ELSIF (absolute < 3392952) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100111100010110111000"; ELSE o_ech_fct <= "110011000011101001001000"; END IF;
        ELSIF (absolute < 3400047) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100111110000101101111"; ELSE o_ech_fct <= "110011000001111010010001"; END IF;
        ELSIF (absolute < 3406871) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001100111111110000010111"; ELSE o_ech_fct <= "110011000000001111101001"; END IF;
        ELSIF (absolute < 3413438) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101000001010110111110"; ELSE o_ech_fct <= "110010111110101001000010"; END IF;
        ELSIF (absolute < 3419762) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101000010111001110010"; ELSE o_ech_fct <= "110010111101000110001110"; END IF;
        ELSIF (absolute < 3425857) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101000100011001000001"; ELSE o_ech_fct <= "110010111011100110111111"; END IF;
        ELSIF (absolute < 3431733) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101000101110100110101"; ELSE o_ech_fct <= "110010111010001011001011"; END IF;
        ELSIF (absolute < 3437403) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101000111001101011011"; ELSE o_ech_fct <= "110010111000110010100101"; END IF;
        ELSIF (absolute < 3442876) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101001000100010111100"; ELSE o_ech_fct <= "110010110111011101000100"; END IF;
        ELSIF (absolute < 3448163) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101001001110101100011"; ELSE o_ech_fct <= "110010110110001010011101"; END IF;
        ELSIF (absolute < 3453272) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101001011000101011000"; ELSE o_ech_fct <= "110010110100111010101000"; END IF;
        ELSIF (absolute < 3458212) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101001100010010100100"; ELSE o_ech_fct <= "110010110011101101011100"; END IF;
        ELSIF (absolute < 3462991) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101001101011101001111"; ELSE o_ech_fct <= "110010110010100010110001"; END IF;
        ELSIF (absolute < 3467616) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101001110100101100000"; ELSE o_ech_fct <= "110010110001011010100000"; END IF;
        ELSIF (absolute < 3472095) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101001111101011011111"; ELSE o_ech_fct <= "110010110000010100100001"; END IF;
        ELSIF (absolute < 3476435) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101010000101111010011"; ELSE o_ech_fct <= "110010101111010000101101"; END IF;
        ELSIF (absolute < 3480641) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101010001110001000001"; ELSE o_ech_fct <= "110010101110001110111111"; END IF;
        ELSIF (absolute < 3484720) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101010010110000110000"; ELSE o_ech_fct <= "110010101101001111010000"; END IF;
        ELSIF (absolute < 3488677) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101010011101110100101"; ELSE o_ech_fct <= "110010101100010001011011"; END IF;
        ELSIF (absolute < 3492518) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101010100101010100110"; ELSE o_ech_fct <= "110010101011010101011010"; END IF;
        ELSIF (absolute < 3496247) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101010101100100110111"; ELSE o_ech_fct <= "110010101010011011001001"; END IF;
        ELSIF (absolute < 3499869) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101010110011101011101"; ELSE o_ech_fct <= "110010101001100010100011"; END IF;
        ELSIF (absolute < 3503389) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101010111010100011101"; ELSE o_ech_fct <= "110010101000101011100011"; END IF;
        ELSIF (absolute < 3506810) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011000001001111010"; ELSE o_ech_fct <= "110010100111110110000110"; END IF;
        ELSIF (absolute < 3510137) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011000111101111001"; ELSE o_ech_fct <= "110010100111000010000111"; END IF;
        ELSIF (absolute < 3513374) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011001110000011110"; ELSE o_ech_fct <= "110010100110001111100010"; END IF;
        ELSIF (absolute < 3516524) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011010100001101100"; ELSE o_ech_fct <= "110010100101011110010100"; END IF;
        ELSIF (absolute < 3519590) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011011010001100110"; ELSE o_ech_fct <= "110010100100101110011010"; END IF;
        ELSIF (absolute < 3522576) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011100000000010000"; ELSE o_ech_fct <= "110010100011111111110000"; END IF;
        ELSIF (absolute < 3525485) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011100101101101101"; ELSE o_ech_fct <= "110010100011010010010011"; END IF;
        ELSIF (absolute < 3528319) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011101011001111111"; ELSE o_ech_fct <= "110010100010100110000001"; END IF;
        ELSIF (absolute < 3531083) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011110000101001011"; ELSE o_ech_fct <= "110010100001111010110101"; END IF;
        ELSIF (absolute < 3533777) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011110101111010001"; ELSE o_ech_fct <= "110010100001010000101111"; END IF;
        ELSIF (absolute < 3536405) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101011111011000010101"; ELSE o_ech_fct <= "110010100000100111101011"; END IF;
        ELSIF (absolute < 3538968) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100000000000011000"; ELSE o_ech_fct <= "110010011111111111101000"; END IF;
        ELSIF (absolute < 3541471) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100000100111011111"; ELSE o_ech_fct <= "110010011111011000100001"; END IF;
        ELSIF (absolute < 3543913) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100001001101101001"; ELSE o_ech_fct <= "110010011110110010010111"; END IF;
        ELSIF (absolute < 3546298) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100001110010111010"; ELSE o_ech_fct <= "110010011110001101000110"; END IF;
        ELSIF (absolute < 3548628) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100010010111010100"; ELSE o_ech_fct <= "110010011101101000101100"; END IF;
        ELSIF (absolute < 3550904) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100010111010111000"; ELSE o_ech_fct <= "110010011101000101001000"; END IF;
        ELSIF (absolute < 3553128) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100011011101101000"; ELSE o_ech_fct <= "110010011100100010011000"; END IF;
        ELSIF (absolute < 3555303) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100011111111100111"; ELSE o_ech_fct <= "110010011100000000011001"; END IF;
        ELSIF (absolute < 3557429) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100100100000110101"; ELSE o_ech_fct <= "110010011011011111001011"; END IF;
        ELSIF (absolute < 3559508) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100101000001010100"; ELSE o_ech_fct <= "110010011010111110101100"; END IF;
        ELSIF (absolute < 3561541) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100101100001000101"; ELSE o_ech_fct <= "110010011010011110111011"; END IF;
        ELSIF (absolute < 3563531) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100110000000001011"; ELSE o_ech_fct <= "110010011001111111110101"; END IF;
        ELSIF (absolute < 3565479) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100110011110100111"; ELSE o_ech_fct <= "110010011001100001011001"; END IF;
        ELSIF (absolute < 3567385) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100110111100011001"; ELSE o_ech_fct <= "110010011001000011100111"; END IF;
        ELSIF (absolute < 3569252) THEN IF i_ech(23) = '0' THEN o_ech_fct <= "001101100111011001100100"; ELSE o_ech_fct <= "110010011000100110011100"; END IF;
        ELSE IF i_ech(23) = '0' THEN o_ech_fct <= "001101100111110110000111";  ELSE o_ech_fct <= "110010011000001001111001"; END IF;                
        END IF;

    end process;
        
end Behavioral;  
                 
