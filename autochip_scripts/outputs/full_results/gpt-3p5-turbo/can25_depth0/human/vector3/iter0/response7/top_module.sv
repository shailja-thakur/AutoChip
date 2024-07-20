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
	// Concatenating input vectors
	wire [29:0] input_concatenated;
	assign input_concatenated = {a, b, c, d, e, f};
	
	// Shifting and splitting output vectors
	assign w = input_concatenated[31:24];
	assign x = input_concatenated[23:16];
	assign y = input_concatenated[15:8];
	assign z = input_concatenated[7:0];
endmodule
