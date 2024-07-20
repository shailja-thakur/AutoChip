module top_module(
	input x,
	input y,
	output z);

	// Internal signals
	wire w1;

	// XOR gate
	xor_gate xor1 (.a(x), .b(y), .z(w1));

	// AND gate
	and_gate and1 (.a(w1), .b(x), .z(z));

endmodule
module xor_gate(
	input a,
	input b,
	output z);

	// XOR gate implementation
	assign z = a ^ b;

endmodule
module and_gate(
	input a,
	input b,
	output z);

	// AND gate implementation
	assign z = a & b;

endmodule
