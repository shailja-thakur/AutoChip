//  This Verilog module is a top-level module that takes in five 4-bit inputs (a, b, c, d, and e) and produces one 4-bit output (q). The output q is a register, meaning that its value will be stored and can be used as an input in other modules.  The module uses an always block to continuously evaluate the value of the input c. Depending on the value of c, the output q will be assigned a different value. If c is 0, then q will be assigned the value of b. If c is 1, then q will be assigned the value of e. If c is 2, then q will be assigned the value of a. If c is 3, then q will be assigned the value of d. If c is any other value, then q will be assigned the value of 4'hf.

module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);
