//  This top Verilog module implements a logic gate that takes four inputs (a, b, c, and d) and outputs a single bit (q). The logic gate is a bitwise OR of the inputs a and b, and a bitwise OR of the inputs c and d. The output q is a bitwise AND of the two ORs. This means that the output q will be 1 only if at least one of the inputs a and b is 1, and at least one of the inputs c and d is 1.

module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
