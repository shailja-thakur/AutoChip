module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Declare local wire variables for the output bits
	wire [7:0] out_0_7;
	wire [7:0] out_8_15;
	wire [7:0] out_16_23;
	wire [7:0] out_24_31;

	// Assign the output bits to the rearranged input bits
	assign out_0_7 = in[7:0];
	assign out_8_15 = in[15:8];
	assign out_16_23 = in[23:16];
	assign out_24_31 = in[31:24];

	// Concatenate the rearranged output bits to form the final output
	assign out = {out_24_31, out_16_23, out_8_15, out_0_7};

endmodule
