module top_module (
	input [3:0] in,
	output wire out_and,
	output wire out_or,
	output wire out_xor
);

	assign out_and = &in;
	assign out_or = |in;
	assign out_xor = ^in;
	
endmodule
