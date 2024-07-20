//  This Verilog module is a simple logic gate that takes two inputs, x and y, and produces an output, z. The output is the logical negation of the exclusive-or (XOR) of the two inputs. In other words, the output is true if either x or y is true, but not both. If both x and y are true, then the output is false. This module is a basic building block for more complex digital logic circuits.

module top_module(
	input x,
	input y,
	output z);
