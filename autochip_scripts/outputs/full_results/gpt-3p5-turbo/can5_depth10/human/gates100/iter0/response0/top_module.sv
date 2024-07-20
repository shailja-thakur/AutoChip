module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	
	assign out_and = &in;
	assign out_or = |in;
	
	// Implement XOR gate
	wire [99:0] in_xor;
	assign in_xor = ^in;
	assign out_xor = |in_xor;

endmodule
