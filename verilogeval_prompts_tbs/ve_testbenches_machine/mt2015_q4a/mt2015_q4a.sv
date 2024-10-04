//  This top module is a simple combinational logic circuit that takes two inputs, x and y, and produces one output, z. The output z is the result of a logical AND operation between the exclusive OR (XOR) of the two inputs and the first input x. In other words, the output z will be high (1) if either x or y is high (1) but not both, and will be low (0) if both x and y are either high (1) or low (0). This is a useful circuit for implementing a 2-input multiplexer.

module top_module(
	input x,
	input y,
	output z);
