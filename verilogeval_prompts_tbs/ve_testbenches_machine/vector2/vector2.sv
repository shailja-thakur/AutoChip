//  This top module is a simple Verilog module that takes an input of 32 bits and outputs the same 32 bits in a different order. The module assigns the output to be the input bits rearranged in 8-bit chunks. The first 8 bits of the input are assigned to the first 8 bits of the output, the second 8 bits of the input are assigned to the second 8 bits of the output, and so on. This module is useful for rearranging the order of bits in a data stream.

module top_module (
	input [31:0] in,
	output [31:0] out
);
