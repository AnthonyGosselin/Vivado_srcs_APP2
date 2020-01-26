----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2020 10:55:14 AM
-- Design Name: 
-- Module Name: med_commande_btn - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mef_commande_btn is
    Port ( CLK : in STD_LOGIC;
           i_reset : in STD_LOGIC;
           i_str_btn : in STD_LOGIC;
           o_selection : out STD_LOGIC_VECTOR(1 downto 0));
end mef_commande_btn;

architecture Behavioral of mef_commande_btn is

type fsm_etat_aff IS (S00,S01,S10,S11);
SIGNAL fsm_EtatCourant, fsm_prochainEtat : fsm_etat_aff;

begin

CLK_Process : process (CLK)
   begin
        if i_reset = '1' then
            fsm_EtatCourant <= S00;
        else
           if CLK'event and (CLK = '1') then
                if (i_str_btn = '1') then
                    fsm_EtatCourant <= fsm_prochainEtat;
               end if;
           end if;
        end if;      
   end process;
   
   
transitions: process(fsm_EtatCourant)
begin
   case fsm_EtatCourant is
        when S00 =>
             fsm_prochainEtat <= S01;
        when S01 =>
             fsm_prochainEtat <= S10;
        when S10 =>
             fsm_prochainEtat <= S11;
        when S11 =>
             fsm_prochainEtat <= S00;
     end case;
  end process;
 
sortie: process(fsm_EtatCourant)
  begin
 
   case fsm_EtatCourant is
        when S00 =>
            o_selection <= "00";
        when S01=>
            o_selection <= "01";
        when S10=>
            o_selection <= "10";
        when S11=>
            o_selection <= "11";
     end case;
   
    end process;


end Behavioral;
