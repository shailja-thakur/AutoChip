// The top Verilog module is a Mealy machine with two inputs (clk and a) and one output (q).
The output q is a 3-bit value.
The input a is an activity signal.
When a is 1, q is set to 4.
When a is 0 and q is 6, q is set to 0.
When a is 0 and q is not 6, q is increased by 1.


module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
