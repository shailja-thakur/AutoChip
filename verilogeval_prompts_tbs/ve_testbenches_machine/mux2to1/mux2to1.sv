//  This Verilog module is a simple multiplexer. It takes two inputs, a and b, as well as a selector input, sel. It then outputs the value of either a or b, depending on the value of sel. If sel is 1, the output will be b, and if sel is 0, the output will be a. This module is useful for selecting between two different values, depending on the value of the selector.

module top_module (
	input a,
	input b,
	input sel,
	output out
);
