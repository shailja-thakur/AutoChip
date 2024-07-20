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
	// Concatenation of inputs
	wire [39:0] concat_inputs;
	assign concat_inputs = {a, b, c, d, e, f, 2'b11};

	// Output ports
	assign w = concat_inputs[39:32];
	assign x = concat_inputs[31:24];
	assign y = concat_inputs[23:16];
	assign z = concat_inputs[15:8];
endmodule
