module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Wire declarations
	wire and_result;
	wire or_result;
	wire xor_result;
	
	// AND operation
	assign and_result = &in;
	assign out_and = and_result;
	
	// OR operation
	assign or_result = |in;
	assign out_or = or_result;
	
	// XOR operation
	assign xor_result = ^in;
	assign out_xor = xor_result;

endmodule
