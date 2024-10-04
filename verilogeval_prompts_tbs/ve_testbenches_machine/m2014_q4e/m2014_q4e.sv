//  This Verilog module is a combinational logic module that takes two input signals, in1 and in2, and produces one output signal, out. The output signal is the logical negation of the logical OR of the two input signals. This means that the output signal will be high (1) if both input signals are low (0), and will be low (0) if either of the input signals is high (1). This module is useful for implementing logic functions such as a NAND gate or a NOR gate.

module top_module (
	input in1,
	input in2,
	output logic out
);
