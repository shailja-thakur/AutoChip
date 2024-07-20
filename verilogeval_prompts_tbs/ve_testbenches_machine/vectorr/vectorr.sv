//  This top Verilog module is a 8-bit unidirectional data port. It takes an 8-bit input in, and outputs an 8-bit signal out. The output of the module is assigned to out based on the value of in. If in = {a,b,c,d,e,f,g,h}, then out = {h,g,f,e,d,c,b,a}.




module top_module (
	input [7:0] in,
	output [7:0] out
);
