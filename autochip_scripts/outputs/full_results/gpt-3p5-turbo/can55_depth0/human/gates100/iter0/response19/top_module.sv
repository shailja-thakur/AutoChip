module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// AND gate implementation
	wire and_result;
	
	assign and_result = &in;
	
	assign out_and = and_result;
	
	
	// OR gate implementation
	wire or_result;
	
	assign or_result = |in;
	
	assign out_or = or_result;
	
	
	// XOR gate implementation
	wire xor_result;
	
	assign xor_result = ^in;
	
	assign out_xor = xor_result;

endmodule
