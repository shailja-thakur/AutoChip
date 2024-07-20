module top_module (
    input a,
    input b,
    output sum,
    output cout
);

	// Instantiate the Half Adder module
	half_adder ha1 (.a(a), .b(b), .sum(sum), .cout(cout));

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);

	// XOR gate to compute the sum
	xor_gate xor1 (.a(a), .b(b), .z(sum));

	// AND gate to compute the carry-out
	and_gate and1 (.a(a), .b(b), .z(cout));

endmodule
module xor_gate (
	input a,
	input b,
	output z
);

	assign z = a ^ b;

endmodule
module and_gate (
	input a,
	input b,
	output z
);

	assign z = a & b;

endmodule
