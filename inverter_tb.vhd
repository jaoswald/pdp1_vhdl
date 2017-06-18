-- Test bed for DEC inverter.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inverter_tb is
end inverter_tb;

architecture arch of inverter_tb is
  signal in0 : std_logic := '0';
  signal emitter : std_logic := '0';
  signal out1 : std_logic;
  signal out2 : std_logic;
  signal out3 : std_logic;
  signal out4 : std_logic;
  
  constant collector3 : std_logic := 'H';     
  constant collector4 : std_logic := 'H';
  
  component inverter
    port (base : in std_logic;
          collector : out std_logic;
          emitter : in std_logic := '0');
    end component;
begin
  -- collectors disconnected
  -- used only as inverter, emitter grounded.
  inv1 : inverter port MAP(base => in0,
                           collector => out1);
  -- emitter controlled.
  inv2 : inverter port map(base => in0,
                           collector => out2,
                           emitter => emitter);

  -- collector connected to "clamped load"
  inv3 : inverter port map(base => in0,
                           collector => out3);
  inv4 : inverter port map(base => in0,
                           collector => out4,
                           emitter => emitter);
  out3 <= collector3;
  out4 <= collector4; 

  main : process
  begin
    report "Starting test.";
    in0 <= '0';
    emitter <= '0';

    wait for 10 ns;
    assert out1 = 'Z'
      report "expected out1: Z saw " & std_logic'image(out1)
      severity failure;
    assert out2 = 'Z'
      report "expected out2: Z saw " & std_logic'image(out2)
      severity failure;
    assert out3 = 'H'
      report "expected out3: H saw " & std_logic'image(out3)
      severity failure;
    assert out4 = 'H'
      report "expected out4: H saw " & std_logic'image(out4)
      severity failure;

    in0 <= '1';
    wait for 10 ns;
    assert out1 = '0'
      report "expected out1: 0 saw " & std_logic'image(out1)
      severity failure;
    assert out2 = '0'
      report "expected out2: 0 saw " & std_logic'image(out2)
      severity failure;
    assert out3 = '0'
      report "expected out3: 0 saw " & std_logic'image(out3)
      severity failure;
    assert out4 = '0'
      report "expected out4: 0 saw " & std_logic'image(out4)
      severity failure;

    emitter <= '1';
    in0 <= '0';
    wait for 10 ns;
    assert out1 = 'Z'
      report "expected out1: Z saw " & std_logic'image(out1)
      severity failure;
    assert out2 = 'Z'
      report "expected out2: Z saw " & std_logic'image(out2)
      severity failure;
    assert out3 = 'H'
      report "expected out3: H saw " & std_logic'image(out3)
      severity failure;
    assert out4 = 'H'
      report "expected out4: H saw " & std_logic'image(out4)
      severity failure;

    in0 <= '1';
    wait for 10 ns;
    assert out1 = '0'
      report "expected out1: 0 saw " & std_logic'image(out1)
      severity failure;
    assert out2 = '1'
      report "expected out1: 0 saw " & std_logic'image(out2)
      severity failure;
    assert out3 = '0'
      report "expected out1: 0 saw " & std_logic'image(out3)
      severity failure;
    assert out4 = '1'
      report "expected out2: 0 saw " & std_logic'image(out4)
      severity failure;

    report "Ending test.";
    wait;
  end process;
end arch;
