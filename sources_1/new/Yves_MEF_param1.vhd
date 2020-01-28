----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2020 10:01:09 AM
-- Design Name: 
-- Module Name: MEF_param1 - Behavioral
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

entity MEF_param1 is
    Port ( i_bclk      : in std_logic;
           i_en : in std_logic;
           i_rst : in STD_LOGIC;
           i_sign : in STD_LOGIC;
           o_rst_cnt : out STD_LOGIC;
           o_enable : out STD_LOGIC;
           o_write_reg : out STD_LOGIC);
end MEF_param1;

architecture Behavioral of MEF_param1 is

  type fsm_cI2S_etats is (
       sta_init,
       sta_pos0,
       sta_pos1,
       sta_pos2,
       sta_posf,
       sta_neg0,
       sta_neg1,
       sta_neg2,
       sta_negf
       );
  signal fsm_currentState, fsm_nextState : fsm_cI2S_etats;

begin

    process(i_en, i_rst)
    begin
        if (i_rst = '1') then
            fsm_currentState <= sta_init;
        else
        if  rising_edge(i_en) then
            fsm_currentState <= fsm_nextState;
        end if;
        end if;
    end process;

transitions_output: process(i_sign, fsm_currentState)
    begin
        case fsm_currentState is
            when sta_init =>
                if (i_sign = '0') then
                    o_rst_cnt    <= '0';
                    o_enable     <= '0';
                    o_write_reg      <= '0';
                    fsm_nextState <= sta_pos0;
                else
                    o_rst_cnt    <= '0';
                    o_enable     <= '0';
                    o_write_reg      <= '0';
                    fsm_nextState <= sta_neg0;
                end if;
            
            when sta_pos0 =>
                if (i_sign = '0') then
                    o_rst_cnt    <= '0';
                o_enable     <= '1';
                o_write_reg      <= '0';
                    fsm_nextState <= sta_pos1;
                else
                o_rst_cnt    <= '0';
                o_enable     <= '1';
                o_write_reg      <= '0';
                    fsm_nextState <= sta_negf;
                end if;
            when sta_pos1 =>
                if (i_sign = '0') then
                o_rst_cnt    <= '0';
                o_enable     <= '0';
                o_write_reg      <= '1';
                    fsm_nextState <= sta_pos2;
                else
                o_rst_cnt    <= '0';
                o_enable     <= '1';
                o_write_reg      <= '0';
                    fsm_nextState <= sta_negf;
                end if;
            when sta_pos2 =>
                o_rst_cnt    <= '1';
                o_enable     <= '0';
                o_write_reg      <= '0';
                fsm_nextState <= sta_posf;
            when sta_posf =>
                if (i_sign ='0') then
                o_rst_cnt    <= '0';
                o_enable     <= '1';
                o_write_reg      <= '0';
                    fsm_nextState <= sta_posf;
                else
                o_rst_cnt    <= '0';
                o_enable     <= '1';
                o_write_reg      <= '0';
                    fsm_nextState <= sta_neg0;
                end if;
            
            when sta_neg0 =>
                if (i_sign = '0') then
                o_rst_cnt    <= '0';
                o_enable     <= '1';
                o_write_reg      <= '0';
                    fsm_nextState <= sta_posf;
                else
                o_rst_cnt    <= '0';
                o_enable     <= '1';
                o_write_reg      <= '0';
                    fsm_nextState <= sta_neg1;
                end if;
            when sta_neg1 =>
                if (i_sign = '0') then
                o_rst_cnt    <= '0';
                o_enable     <= '1';
                o_write_reg      <= '0';
                    fsm_nextState <= sta_posf;
                else
                o_rst_cnt    <= '0';
                o_enable     <= '0';
                o_write_reg      <= '1';
                    fsm_nextState <= sta_neg2;
                end if;
            when sta_neg2 =>
                o_rst_cnt    <= '1';
                o_enable     <= '0';
                o_write_reg      <= '0';
                fsm_nextState <= sta_negf;
            when sta_negf =>
                if (i_sign ='0') then
                o_rst_cnt    <= '0';
                o_enable     <= '1';
                o_write_reg      <= '0';
                    fsm_nextState <= sta_pos0;
                else
                o_rst_cnt    <= '0';
                o_enable     <= '1';
                o_write_reg      <= '0';
                    fsm_nextState <= sta_negf;
                end if;
        end case;
    end process;    
end Behavioral;
