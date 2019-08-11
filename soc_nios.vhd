library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity soc_nios is
  port (clk,rst: in std_logic;
	    leds: out std_logic_vector(7 downto 0));
 end soc_nios ;

architecture struct of soc_nios is
	component nios_system is
		port (
			clk_clk                          : in  std_logic                    := 'X'; -- clk
			reset_reset_n                    : in  std_logic                    := 'X'; -- reset_n
			pio_0_external_connection_export : out std_logic_vector(7 downto 0)         -- export
		);
	end component nios_system;
begin
   	u0 : component nios_system
		port map (
			clk_clk                          => clk,  --                       clk.clk
			reset_reset_n                    => rst,  --                     reset.reset_n
			pio_0_external_connection_export => leds 	-- pio_0_external_connection.export
		);
end struct;
