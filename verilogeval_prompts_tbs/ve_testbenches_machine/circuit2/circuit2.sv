//  This Verilog module implements a logic function that takes four inputs (a, b, c, and d) and produces one output (q). It performs a bitwise XOR operation on the inputs, and then inverts the result. This means that the output will be high when an odd number of inputs are high, and low when an even number of inputs are high.

module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
