-- Example of series/parallel inverter connection
--

library ieee;
use ieee.std_logic_1164.all;

-- a NOR gate (in the DEC terminology "an OR gate for negative levels)
-- constructed from the DEC inverters.
entity inverter_or is
  port (a,b : in std_logic;
        c : out std_logic);
end inverter_or;

architecture structural of inverter_or is
  constant clamped_load : std_logic := 'H';
  component inverter
    port (base : in std_logic;
          collector : out std_logic;
          emitter : in std_logic := '0');
  end component;

begin
  c <= clamped_load;
  inv_a : inverter port map(base => a,
                            collector => c);
  inv_b : inverter port map(base => b,
                            collector => c);
end structural;

library ieee;
use ieee.std_logic_1164.all;

-- a NAND gate (in the DEC terminology "an AND gate for negative levels")
-- constructed from the DEC inverters.
entity inverter_and is
  port (a,b : in std_logic;
        c : out std_logic);
end inverter_and;

architecture structural of inverter_and is
  constant clamped_load : std_logic := 'H';
  signal coll_b : std_logic;
  component inverter
    port (base : in std_logic;
          collector : out std_logic;
          emitter : in std_logic := '0');
  end component;

begin
  c <= clamped_load;
  inv_a : inverter port map(base => a,
                            collector => c,
                            emitter => coll_b);
  inv_b : inverter port map(base => b,
                            collector => coll_b);
end structural;

library ieee;
use ieee.std_logic_1164.all;

entity inverter_example is
  port (a,b,c,d,e,f,g : in std_logic;
        h : out std_logic);
end inverter_example;

architecture structural of inverter_example is
  signal coll_a, coll_b, coll_e : std_logic;
  constant clamped_load : std_logic := 'H';
  
  component inverter
    port (base : in std_logic;
          collector : out std_logic;
          emitter : in std_logic := '0');
  end component;

begin
  h <= clamped_load;
  inv_a : inverter port map(base => a,
                            collector => coll_a);
  inv_b : inverter port map(base => b,
                            collector => coll_b,
                            emitter => coll_a);
  inv_c : inverter port map(base => c,
                            collector => h,
                            emitter => coll_b);
  inv_d : inverter port map(base => d,
                            collector => coll_a);
  inv_e : inverter port map(base => e,
                            collector => coll_e);
  inv_f : inverter port map(base => f,
                            collector => coll_b,
                            emitter => coll_e);
  inv_g : inverter port map(base => g,
                            collector => coll_b);

  -- This wiring arrangement is a representation of
  -- not(h) <= c or (b or a and d) and (e or f) and g
end structural;

entity inverter_and_test is
end inverter_and_test;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture arch of inverter_and_test is
  signal in_a : std_logic;
  signal in_b : std_logic;
  signal out_c : std_logic;
  
  signal expected_c : std_logic;
  signal expected_c_resolved : std_logic;

  component inverter_and
    port (a,b : in std_logic;
          c : out std_logic);
  end component;

  begin
  example : inverter_and port map(
    a => in_a,
    b => in_b,
    c => out_c);

  expected_c <= in_a and in_b;
  expected_c_resolved <= 'H' when expected_c = '0' else '0';

  test : process
  begin 
    report "Starting inverter_and_test.";
    in_a <= '0';
    in_b <= '0';
    wait for 1 ns;
    assert expected_c_resolved = out_c
        report "expected out: " & std_logic'image(not(expected_c)) & " i.e. " &
      std_logic'image(expected_c_resolved) & " saw " &
      std_logic'image(out_c) &
        " a = " & std_logic'image(in_a) & " b = " & std_logic'image(in_b)
        severity error;

    in_b <= '1';
    wait for 1 ns;
    assert expected_c_resolved = out_c
        report "expected out: " & std_logic'image(not(expected_c)) & " i.e. " &
      std_logic'image(expected_c_resolved) & " saw " &
      std_logic'image(out_c) &
        " a = " & std_logic'image(in_a) & " b = " & std_logic'image(in_b)
        severity error;

    in_a <= '1';
    wait for 1 ns;
    assert expected_c_resolved = out_c
        report "expected out: " & std_logic'image(not(expected_c)) & " i.e. " &
      std_logic'image(expected_c_resolved) & " saw " &
      std_logic'image(out_c) &
        " a = " & std_logic'image(in_a) & " b = " & std_logic'image(in_b)
        severity error;

    in_b <= '0';
    wait for 1 ns;
    assert expected_c_resolved = out_c
        report "expected out: " & std_logic'image(not(expected_c)) & " i.e. " &
      std_logic'image(expected_c_resolved) & " saw " &
      std_logic'image(out_c) &
        " a = " & std_logic'image(in_a) & " b = " & std_logic'image(in_b)
      severity error;

    report "Ending inverter_and_test.";
    wait;
  end process;
end arch;

entity inverter_or_test is
end inverter_or_test;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture arch of inverter_or_test is
  signal in_a : std_logic;
  signal in_b : std_logic;
  signal out_c : std_logic;
  
  signal expected_c : std_logic;
  signal expected_c_resolved : std_logic;

  component inverter_or
    port (a,b : in std_logic;
          c : out std_logic);
  end component;

  begin
  example : inverter_or port map(
    a => in_a,
    b => in_b,
    c => out_c);

  expected_c <= in_a or in_b;
  expected_c_resolved <= 'H' when expected_c = '0' else '0';

  test : process
  begin 
    report "Starting inverter_or_test.";
    in_a <= '0';
    in_b <= '0';
    wait for 1 ns;
    assert expected_c_resolved = out_c
        report "expected out: " & std_logic'image(not(expected_c)) & " i.e. " &
      std_logic'image(expected_c_resolved) & " saw " &
      std_logic'image(out_c) &
        " a = " & std_logic'image(in_a) & " b = " & std_logic'image(in_b)
        severity error;

    in_b <= '1';
    wait for 1 ns;
    assert expected_c_resolved = out_c
        report "expected out: " & std_logic'image(not(expected_c)) & " i.e. " &
      std_logic'image(expected_c_resolved) & " saw " &
      std_logic'image(out_c) &
        " a = " & std_logic'image(in_a) & " b = " & std_logic'image(in_b)
        severity error;

    in_a <= '1';
    wait for 1 ns;
    assert expected_c_resolved = out_c
        report "expected out: " & std_logic'image(not(expected_c)) & " i.e. " &
      std_logic'image(expected_c_resolved) & " saw " &
      std_logic'image(out_c) &
        " a = " & std_logic'image(in_a) & " b = " & std_logic'image(in_b)
        severity error;

    in_b <= '0';
    wait for 1 ns;
    assert expected_c_resolved = out_c
        report "expected out: " & std_logic'image(not(expected_c)) & " i.e. " &
      std_logic'image(expected_c_resolved) & " saw " &
      std_logic'image(out_c) &
        " a = " & std_logic'image(in_a) & " b = " & std_logic'image(in_b)
      severity error;

    report "Ending inverter_or_test.";
    wait;
  end process;
end arch;


entity inverter_example_test is
end inverter_example_test;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture arch of inverter_example_test is
  signal in_s : std_logic_vector(0 to 6);
  signal h : std_logic;
  signal expected_h : std_logic;
  signal expected_h_resolved : std_logic;

  component inverter_example
    port (a,b,c,d,e,f,g : in std_logic;
          h : out std_logic);
  end component;

  begin
  example : inverter_example port map(
    a => in_s(0),
    b => in_s(1),
    c => in_s(2),
    d => in_s(3),
    e => in_s(4),
    f => in_s(5),
    g => in_s(6),
    h => h);

  expected_h <= in_s(2) or ((in_s(1) or (in_s(0) and in_s(3))) and
                            ((in_s(4) or in_s(5)) and
                             in_s(6)));
  expected_h_resolved <= 'H' when expected_h = '0' else '0';

  test : process
  begin
    report "Starting test.";
    stim : for i in 0 to 127 loop
      in_s <= std_logic_vector(to_unsigned(i, 7));
      wait for 10 ns;
      report "i " & integer'image(i) & " output: " & std_logic'image(h);
      assert expected_h_resolved = h
        report "expected out: " & std_logic'image(not(expected_h)) & " i.e. " &
        std_logic'image(expected_h_resolved) & " saw " & std_logic'image(h) &
        " i = " & integer'image(i)  severity error;
    end loop;
    wait;
  end process;
  end;

  
