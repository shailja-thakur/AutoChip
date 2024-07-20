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

	wire [41:0] concat_output;

	assign concat_output = {a, b, c, d, e, f, 2'b11};

	assign w = concat_output[41:34];
	assign x = concat_output[33:26];
	assign y = concat_output[25:18];
	assign z = concat_output[17:10];

endmodule
