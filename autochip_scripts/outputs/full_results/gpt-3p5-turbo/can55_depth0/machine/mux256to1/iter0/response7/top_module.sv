module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Integer parameter to hold the size of the input vector
	parameter INPUT_SIZE = 256;

	// Create a wire to hold the selected bit from the input vector
	wire selected_bit;

	// Instantiate a binary decoder to select the appropriate bit from the input vector
	bin_decoder decoder (
		.in(sel),
		.out(selected_bit)
	);

	// Assign the selected bit from the input vector to the output
	assign out = in[selected_bit];

	// Binary Decoder module definition
	module bin_decoder (
		input [7:0] in,
		output [7:0] out
	);
		// wire variables for each output bit
		wire out0, out1, out2, out3, out4, out5, out6, out7;

		// Bitwise AND gates to generate the output
		assign out0 = in[0] & ~in[1] & ~in[2] & ~in[3] & ~in[4] & ~in[5] & ~in[6] & ~in[7];
		assign out1 = ~in[0] & in[1] & ~in[2] & ~in[3] & ~in[4] & ~in[5] & ~in[6] & ~in[7];
		assign out2 = ~in[0] & ~in[1] & in[2] & ~in[3] & ~in[4] & ~in[5] & ~in[6] & ~in[7];
		assign out3 = ~in[0] & ~in[1] & ~in[2] & in[3] & ~in[4] & ~in[5] & ~in[6] & ~in[7];
		assign out4 = ~in[0] & ~in[1] & ~in[2] & ~in[3] & in[4] & ~in[5] & ~in[6] & ~in[7];
		assign out5 = ~in[0] & ~in[1] & ~in[2] & ~in[3] & ~in[4] & in[5] & ~in[6] & ~in[7];
		assign out6 = ~in[0] & ~in[1] & ~in[2] & ~in[3] & ~in[4] & ~in[5] & in[6] & ~in[7];
		assign out7 = ~in[0] & ~in[1] & ~in[2] & ~in[3] & ~in[4] & ~in[5] & ~in[6] & in[7];

		// Assign the output bits from the decoder
		assign out = {out7, out6, out5, out4, out3, out2, out1, out0};
	endmodule
