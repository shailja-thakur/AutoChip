module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

	// Wire for intermediate output
	wire [99:0] intermediate_out;

	// Logic to determine the output
	assign intermediate_out = sel ? b : a;
	assign out = intermediate_out;

endmodule
