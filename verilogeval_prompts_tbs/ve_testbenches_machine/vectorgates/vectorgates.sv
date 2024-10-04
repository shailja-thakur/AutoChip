//  This Verilog module is used to perform bitwise and logical operations on two 3-bit inputs, a and b. The module has five output ports, out_or_bitwise, out_or_logical, and out_not.  The out_or_bitwise port is used to output the bitwise OR of the two 3-bit inputs, a and b. This is done by assigning the output port to the bitwise OR of the two inputs.  The out_or_logical port is used to output the logical OR of the two 3-bit inputs, a and b. This is done by assigning the output port to the logical OR of the two inputs.  The out_not port is used to output the bitwise NOT of the two 3-bit inputs, a and b. This is done by assigning the output port to the bitwise NOT of the two inputs, in reverse order.

module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);
