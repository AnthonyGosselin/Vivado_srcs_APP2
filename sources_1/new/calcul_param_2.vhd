
---------------------------------------------------------------------------------------------
--    calcul_param_2.vhd   (temporaire)
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

component reg_nbits is
generic (nbits : integer := 48);
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
    
signal sum : std_logic_vector (47 downto 0);
signal output : signed (47 downto 0);
signal product : signed (95 downto 0);
signal squared : signed (47 downto 0);

---------------------------------------------------------------------------------------------
--    Description comportementale
---------------------------------------------------------------------------------------------
begin 

sum_reg : reg_nbits
generic map (nbits => 48)
  Port map ( 
    i_clk       => i_bclk,
    i_reset     => i_reset,
    i_en        => i_en,
    i_dat       => std_logic_vector(output),
    o_dat       => sum
);

--process(i_en, i_reset)
--begin
--    if i_reset = '1' then
--        output <= (others => '0');
--    end if;
--end process;

squared <= signed(i_ech) * signed(i_ech);
output <= squared + product(95 downto 48);
product <= (signed(sum) * 31/32);

o_param <= std_logic_vector(output(47 downto 40));

end Behavioral;
