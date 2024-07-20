module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal signals
	wire and_out;
	wire xor_out;

	// Implement half adder logic
	assign and_out = a & b;
	assign xor_out = a ^ b;
	assign sum = xor_out;
	assign cout = and_out;

endmodule
