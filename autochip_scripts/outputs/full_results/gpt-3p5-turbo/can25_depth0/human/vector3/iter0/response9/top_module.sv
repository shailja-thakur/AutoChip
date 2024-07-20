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

	// Concatenating the input vectors
	wire [29:0] concatenated_input;
	assign concatenated_input = {a, b, c, d, e, f};
	
	// Appending two '1' bits to the concatenated input
	wire [31:0] appended_input;
	assign appended_input = {concatenated_input, 2'b11};
	
	// Splitting the concatenated and appended input into output vectors
	assign w = appended_input[31:24];
	assign x = appended_input[23:16];
	assign y = appended_input[15:8];
	assign z = appended_input[7:0];

endmodule
