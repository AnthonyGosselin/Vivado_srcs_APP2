----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/27/2020 11:47:43 AM
-- Design Name: 
-- Module Name: MEF_param3 - Behavioral
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

entity MEF_param3 is
    Port ( i_bclk      : in std_logic;
       i_rst : in STD_LOGIC;
       i_dat : in STD_LOGIC_VECTOR (23 downto 0);
       i_cmp_dat : in STD_LOGIC_VECTOR (23 downto 0);
       i_cnt : in STD_LOGIC_VECTOR (6 downto 0);
       i_start : STD_LOGIC;
       o_rst_cnt : out STD_LOGIC;
       o_enable_cnt : out STD_LOGIC;
       o_write_cmp_reg : out STD_LOGIC;
       o_write_o_reg : out STD_LOGIC);
end MEF_param3;

architecture Behavioral of MEF_param3 is

  type fsm_cI2S_etats is (
       sta_init,
       sta_compare,
       sta_write
       );
  signal fsm_currentState, fsm_nextState : fsm_cI2S_etats;

begin

    process(i_bclk, i_rst)
    begin
        if (i_rst = '1') then
            fsm_currentState <= sta_init;
        else
        if  rising_edge(i_bclk) then
            fsm_currentState <= fsm_nextState;
        end if;
        end if;
    end process;

transitions_output: process(i_start, fsm_currentState)
    begin
        case fsm_currentState is
            when sta_init =>
                if (i_start = '1') then
                    o_rst_cnt    <= '0';
                    o_enable_cnt <= '1';
                    o_write_cmp_reg <= '1';
                    o_write_o_reg <= '0';
                    fsm_nextState <= sta_compare;
                else
                    o_rst_cnt    <= '1';
                    o_enable_cnt <= '0';
                    o_write_cmp_reg <= '0';
                    o_write_o_reg <= '0';
                    fsm_nextState <= sta_init;
                end if;
            when sta_compare =>
                if (i_cnt < "0110000"  and i_dat > i_cmp_dat) then
                    o_rst_cnt    <= '0';
                    o_enable_cnt <= '1';
                    o_write_cmp_reg <= '1';
                    o_write_o_reg <= '0';
                    fsm_nextState <= sta_write;
                elsif (i_cnt < "0110000"  and i_dat <= i_cmp_dat) then
                    o_rst_cnt    <= '0';
                    o_enable_cnt <= '1';
                    o_write_cmp_reg <= '0';
                    o_write_o_reg <= '0';
                    fsm_nextState <= sta_compare;
                else
                    o_rst_cnt    <= '1';
                    o_enable_cnt <= '0';
                    o_write_cmp_reg <= '0';
                    o_write_o_reg <= '1';
                    fsm_nextState <= sta_init;
                end if;
            when sta_write =>
                o_rst_cnt <= '0';
                o_enable_cnt <= '0';
                o_write_cmp_reg <= '0';
                o_write_o_reg <= '0';
                fsm_nextState <= sta_compare;
        end case;
    end process;    
end Behavioral;
