module top_module(
	input a,
	input b,
	output z);

	// Definition of gates
	and_gate and1(
		.a(x),
		.b(y),
		.z(a_and_b) // Output of first AND gate is a_and_b
	);

	and_gate and2(
		.a(y),
		.b(x),
		.z(b_and_a) // Output of second AND gate is b_and_a
	);

	and_gate and3(
		.a(a_and_b), // Input a_and_b from first AND gate
		.b(b_and_a), // Input b_and_a from second AND gate
		.z(z) // Output of third AND gate is z
	);

endmodule
module and_gate(
	input a,
	input b,
	output z);

	assign z = a & b; // Output z is the logical AND operation of inputs a and b

endmodule
