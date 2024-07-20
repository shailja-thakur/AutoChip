module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Define intermediate signals
	wire x1, x2, x3, x4;

	// Create instantiations of XOR and AND gates
	xor_gate xor1 (.a(a), .b(b), .y(x1));
	xor_gate xor2 (.a(x1), .b(cin), .y(x2));
	and_gate and1 (.a(a), .b(b), .y(x3));
	and_gate and2 (.a(x1), .b(cin), .y(x4));

	// Create sum and carry_out signals
	assign sum = x2;
	assign cout = x3 | x4;

endmodule
