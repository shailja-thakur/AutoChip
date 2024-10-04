//  The top Verilog module is a combinational logic module that takes in 8 inputs and produces 2 outputs. The first output, p1y, is the result of a logical AND operation on the first three inputs (p1a, p1b, and p1c) and a logical OR operation on the last three inputs (p1d, p1e, and p1f). The second output, p2y, is the result of a logical AND operation on the first two inputs (p2a and p2b) and a logical OR operation on the last two inputs (p2c and p2d). The module does not contain any state elements, so the outputs are only dependent on the inputs.

module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
