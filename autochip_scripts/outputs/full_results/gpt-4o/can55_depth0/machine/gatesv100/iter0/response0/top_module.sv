module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Shift the input signal by one bit to the left
	wire [99:0] in_shifted;
	assign in_shifted = {in[98:0], 1'b0};
	
	// out_both - Bitwise AND between in and the left-shifted in
	assign out_both = in[99:1] & in_shifted[99:1];
	
	// out_any - Bitwise OR between in and the left-shifted in
	assign out_any = in | in_shifted[99:1];
	
	// out_different - Bitwise XOR between in and the left-shifted in, special handling for the first bit
	assign out_different[0] = in[0] ^ in[99];
	assign out_different[99:1] = in[99:1] ^ in_shifted[99:1];

endmodule
