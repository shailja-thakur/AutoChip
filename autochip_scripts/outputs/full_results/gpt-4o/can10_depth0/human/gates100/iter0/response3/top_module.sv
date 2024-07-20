module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

assign out_and = &in;        // AND all 100 bits together
assign out_or = |in;         // OR all 100 bits together
assign out_xor = ^in;        // XOR all 100 bits together

endmodule
