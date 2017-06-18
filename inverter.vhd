-- VHDL model of the standard DEC System Module inverter.
--
-- The inverters themselves were PNP emitter-followers.
-- Note: this assumes '1' is -3V, '0' is ground.
--
library ieee;
use ieee.std_logic_1164.all;

entity inverter is
  port (base : in std_logic;
        collector : out std_logic;
        emitter : in std_logic := '0');
end inverter;

architecture basic of inverter is
begin
  collector <= emitter when base = '1' else 'Z';
end basic;
