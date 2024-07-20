module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

	// Shift the input signal by one bit to the left
	wire [99:0] in_shifted;
	assign in_shifted = {in[98:0], 1'b0};
	
	// Generate out_both (bit-wise AND of 'in' and 'in_shifted')
	assign out_both = in[99:1] & in_shifted[99:1];

	// Generate out_any (bit-wise OR of 'in' and 'in_shifted')
	assign out_any = in | in_shifted;

	// Generate out_different (bit-wise XOR of 'in' and 'in_shifted')
	assign out_different = {in[99] ^ in[0], in[98:0] ^ in_shifted[98:0]};

endmodule
