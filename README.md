* PDP-1 Module-level simulation

2015-05-07 josephoswald@gmail.com

The goal of this project is to faithfully simulate the Digital PDP-1 at the
level of the Digital System Modules.

The Digital Equipment Corporation's first product were a series of "laboratory
modules"
https://en.wikipedia.org/wiki/History_of_Digital_Equipment_Corporation#Digital_modules. These were soon repackaged as "Digital Systems Modules." These could
be assembled in 19-inch equipment racks and wired along a backplane. The
modules could contain digital logic elements, such as inverters or flip-flops,
and were used to construct systems such as a memory tester for magnetic core
planes.

The PDP-1, the first in the "Programmable Data Processor" product line, was
constructed from these System Modules.

Various efforts have been made to simulate the PDP-1 system; the goal of this
project is to reproduce the system by wiring together simulations of the
System Modules described in VHDL. Ideally, this should allow cycle-accurate
simulation.

Although the Digital Systems Modules can be described as digital circuit
elements, they have some idiosyncrasies that do not allow a trivial mapping of
this VHDL description to an FPGA. Most significantly, many of the blocks were
driven by or produced voltage pulses instead of logic levels. For example, the
basic flip-flop was designed to be set or reset through specified pulses, with
the input pulse duration meant to be less than the propagation delay to the
flip-flop output. TODO(jao): verify this. Also, the elements were defined
at somewhat lower level than standard boolean gates: the "inverter" element
was a three-terminal device, allowing it to be wired more like a "pass gate",
where the inverter input output when the transistor was turned on depended
on the third terminal emitter voltage. They could be, therefore, wired
"in series" on this third terminal (though the base inputs were in parallel)
to construct higher-level gates. Flip-flops provided an additional
"pulse output" when set or reset in addition to their static outputs.
The basic logic levels were -3V and ground.

Although some of the blocks provided clock timing signals, the timing of the
systems was largely asynchronous. Control signals such register transfer were
specified as pulses.

Digital module notation: "black" diamonds map -3 V to "assertion" or 1,
"hollow" diamonds map 0 V to "assertion." Arrow heads were used to show
pulse control lines, with a solid arrowhead 

Modern FPGAs strongly favor synchronous system descriptions and express logic
through lookup tables, and not at a transistor level.

VHDL itself, however, can describe asynchronous logic, including timing
dependencies of pulse-driven logic. Such logic cannot be directly synthesized,
however.

A second goal, after an accurate asynchronous description of the PDP-1 is
developed, would be to develop and validate a higher-level synchronous
design which could then be implemented on an FPGA.

GHDL usage
  "analyze"
  ghdl -a inverter.vhd inverter_example.vhd
  "elaborate"
  ghdl -e inverter_example_test # this is an entity name, not a file
  "run"
  ghdl -r inverter_example_test # again, entity name
  




