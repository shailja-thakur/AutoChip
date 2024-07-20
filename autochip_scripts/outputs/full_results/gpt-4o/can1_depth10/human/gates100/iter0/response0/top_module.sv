module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

assign out_and = &in;  // Reduction AND
assign out_or = |in;   // Reduction OR
assign out_xor = ^in;  // Reduction XOR

endmodule
