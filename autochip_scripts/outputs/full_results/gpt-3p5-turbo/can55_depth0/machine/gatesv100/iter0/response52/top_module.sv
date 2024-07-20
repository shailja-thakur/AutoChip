module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	assign out_both = in[98:0] & in[99:1];   // Performing bitwise AND operation between the two input signals
	
	assign out_any = in[99:0] | in[99:1];   // Performing bitwise OR operation between the two input signals
	
	assign out_different[0] = in[0] ^ in[99];   // Performing bitwise XOR operation between the first bit of the first input signal and the last bit of the second input signal
	
	assign out_different[99:1] = in[99:1] ^ in[98:0];   // Performing bitwise XOR operation between the corresponding bits of the two input signals
	
endmodule
