----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2020 01:05:53 PM
-- Design Name: 
-- Module Name: mef_positif_param1 - Behavioral
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

entity mef_positif_param1 is
    Port ( i_ech            : in STD_LOGIC_VECTOR(23 downto 0);
           i_bclk           : in std_logic;
           i_reset          : in std_logic;  
           i_en             : out std_logic;
           o_cpt_bit_reset  : out std_logic;
           Affirmed         : out std_logic
    );
end mef_positif_param1;

architecture Behavioral of mef_positif_param1 is

    -- définition de la MEF de contrôle
   type fsm_positif_etats is (
         sta_init,
         sta_neg1,
         sta_neg2,
         sta_negf,
         sta_pos1,
         sta_pos2,
         sta_pos3,
         sta_posf
         );

    signal fsm_EtatCourant, fsm_prochainEtat : fsm_positif_etats;

begin

   reglrc_I2S: process ( i_bclk, i_reset)
   begin
        if i_reset = '1' then
            fsm_EtatCourant <= sta_init;
        else
           if i_bclk'event and (i_bclk = '1') then
               fsm_EtatCourant <= fsm_prochainEtat;
           end if;
        end if;
   end process;
   
   -- conditions de transitions
transitions: process(fsm_EtatCourant)
  begin
   case fsm_EtatCourant is
        when sta_init =>
            if (i_ech(23) = '0') then
                fsm_prochainEtat <= sta_pos1;
            else
                fsm_prochainEtat <= sta_neg1;
            end if;
        when sta_neg1 =>                     -------------------------------------------------------------------------------------
             if(i_ech(23) = '0') then            -- A verifier si les clocks sont synchro aka pas vérifier 3 fois la meme value
                 fsm_prochainEtat <= sta_posf;  -------------------------------------------------------------------------------------
             else
                 fsm_prochainEtat <= sta_neg2;
             end if;
         when sta_neg2 =>                     -------------------------------------------------------------------------------------
             if(i_ech(23) = '0') then            -- A verifier si les clocks sont synchro aka pas vérifier 3 fois la meme value
                 fsm_prochainEtat <= sta_posf;  -------------------------------------------------------------------------------------
             else
                 fsm_prochainEtat <= sta_negf;
             end if;
          when sta_negf =>                     -------------------------------------------------------------------------------------
             if(i_ech(23) = '0') then            -- A verifier si les clocks sont synchro aka pas vérifier 3 fois la meme value
                 fsm_prochainEtat <= sta_pos1;  -------------------------------------------------------------------------------------
             else
                 fsm_prochainEtat <= sta_negf;
             end if;
         when sta_pos1 =>
            if (i_ech(23) = '0') then
                fsm_prochainEtat <= sta_pos2;
            else
                fsm_prochainEtat <= sta_negf;
            end if;
         when sta_pos2 =>
            if( i_ech(23) = '0' ) then
                fsm_prochainEtat <= sta_pos3;
            else
                fsm_prochainEtat <= sta_negf;
            end if;
         when sta_pos3 =>
            fsm_prochainEtat <= sta_posf;
        when sta_posf =>
            if ( i_ech(23) = '0' ) then
                fsm_prochainEtat <= sta_posf;
            else
                fsm_prochainEtat <= sta_neg1;
            end if;
        when others =>
            fsm_prochainEtat <= sta_init;
     end case;
  end process;
 
sortie: process(fsm_EtatCourant)
  begin
 
   case fsm_EtatCourant is
        when sta_init =>
            o_cpt_bit_reset    <= '0';
            i_en               <= '1';
            Affirmed           <= '0';
        when sta_neg1=>
            o_cpt_bit_reset    <= '0';
            i_en               <= '1';
            Affirmed           <= '0';
        when sta_neg2=>
            o_cpt_bit_reset    <= '0';
            i_en               <= '1';
            Affirmed           <= '0';
        when sta_negf=>
            o_cpt_bit_reset    <= '0';
            i_en               <= '1';
            Affirmed           <= '0';
        when sta_pos1=>
            o_cpt_bit_reset    <= '0';
            i_en               <= '1';
            Affirmed           <= '0';
        when sta_pos2=>
            o_cpt_bit_reset    <= '0';
            i_en               <= '1';
            Affirmed           <= '0';
        when sta_pos3=>
            o_cpt_bit_reset    <= '1';
            i_en               <= '1';
            Affirmed           <= '1';
        when sta_posf=>
            o_cpt_bit_reset    <= '0';
            i_en               <= '1';
            Affirmed           <= '0';
     end case;
    end process;


end Behavioral;
