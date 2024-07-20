module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	wire in_and;
	wire in_or;
	wire in_xor;

	assign out_and = in_and;
	assign out_or = in_or;
	assign out_xor = in_xor;

	assign in_and = &in;
	assign in_or = |in;
	assign in_xor = ^in;

endmodule
