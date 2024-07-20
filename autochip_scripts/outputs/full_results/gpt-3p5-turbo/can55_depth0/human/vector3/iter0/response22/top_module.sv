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

	// Add two 1 bits at LSB positions
	wire [31:0] concatenated_output;
	assign concatenated_output = {concatenated_input, 2'b11};

	// Split concatenated output into four 8-bit vectors
	assign w = concatenated_output[31:24];
	assign x = concatenated_output[23:16];
	assign y = concatenated_output[15:8];
	assign z = concatenated_output[7:0];

endmodule
