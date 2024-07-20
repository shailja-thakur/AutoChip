//  This top Verilog module is a 4-bit selector module. It takes in a 1024-bit input vector (in) and an 8-bit selection vector (sel) and outputs a 4-bit vector (out). The selection vector (sel) is used to select a 4-bit block from the input vector (in). The output vector (out) is the 4-bit block selected from the input vector (in) based on the selection vector (sel). The selection vector (sel) is used to calculate the starting index of the 4-bit block in the input vector (in). The 4-bit block is then extracted from the input vector (in) starting from the calculated index and is assigned to the output vector (out).

module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
