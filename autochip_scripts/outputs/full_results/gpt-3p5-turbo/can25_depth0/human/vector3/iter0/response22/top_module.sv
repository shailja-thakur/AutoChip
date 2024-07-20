module top_module (
	input [4:0] a,
	input [4:0] b,
	input [4:0] c,
	input [4:0] d,
	input [4:0] e,
	input [4:0] f,
	output [7:0] w,
	output [7:0] x,
	output [7:0] y,
	output [7:0] z
);

	// Concatenate input vectors
	wire [29:0] concatenated_input;
	assign concatenated_input = {a, b, c, d, e, f};

	// Add two 1 bits in the LSB positions
	wire [31:0] output_with_ones;
	assign output_with_ones = {concatenated_input, 2'b11};

	// Split up the output into four output vectors
	assign w = output_with_ones[31:24];
	assign x = output_with_ones[23:16];
	assign y = output_with_ones[15:8];
	assign z = output_with_ones[7:0];

endmodule
