module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Intermediate signals
	wire [99:0] and_temp;
	wire [99:0] or_temp;
	wire [99:0] xor_temp;
	
	// AND operation
	assign and_temp = in & (100'b1);
	assign out_and = &and_temp;
	
	// OR operation
	assign or_temp = in | (100'b0);
	assign out_or = |or_temp;
	
	// XOR operation
	assign xor_temp = in ^ (100'b0);
	assign out_xor = ^xor_temp;

endmodule
