module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

	// Shift the input signal by one bit to the right
	wire [99:0] shifted_in;
	assign shifted_in = {1'b0, in[99:1]};

	// Generate out_both by performing bit-wise AND operation
	assign out_both = in[99:1] & shifted_in[98:0];

	// Generate out_any by performing bit-wise OR operation
	assign out_any = in | shifted_in;

	// Generate the first bit of out_different
	assign out_different[0] = in[0] ^ shifted_in[99];

	// Generate the rest of out_different by performing bit-wise XOR operation
	assign out_different[99:1] = in[99:1] ^ shifted_in[98:0];

endmodule
