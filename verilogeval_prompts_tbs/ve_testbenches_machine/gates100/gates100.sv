//  This module is used to perform logical operations on a 100-bit input vector. The module has four ports: an input port, in, and three output ports, out_and, out_or, and out_xor. The input port, in, is a 100-bit vector. The output ports, out_and, out_or, and out_xor, are all single-bit outputs.  The module performs the logical operations of AND, OR, and XOR on the input vector. The AND operation is performed by taking the logical AND of all the bits in the input vector, and assigning the result to the out_and output port. The OR operation is performed by taking the logical OR of all the bits in the input vector, and assigning the result to the out_or output port. The XOR operation is performed by taking the logical XOR of all the bits in the input vector, and assigning the result to the out_xor output port.

module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
