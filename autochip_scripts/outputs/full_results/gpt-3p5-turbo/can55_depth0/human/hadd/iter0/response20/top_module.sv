module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wires
	wire xor_out;
	wire and_out;

	// Implement XOR and AND gates
	assign xor_out = a ^ b;
	assign and_out = a & b;

	// Output the sum and carry-out
	assign sum = xor_out;
	assign cout = and_out;
	
endmodule
