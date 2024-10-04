//  This Verilog module is a simple combinational logic module that takes three input bits and produces two output bits. The module is named top and it has three inputs, in[2:0], and two outputs, out[1:0]. The output of the module is calculated by adding the three input bits together. The result of the addition is stored in the two output bits, out[1:0]. The most significant bit of the result is stored in out[1] and the least significant bit is stored in out[0]. The module does not have any internal state and it does not use any instantiated modules.

module top_module (
	input [2:0] in,
	output [1:0] out
);
