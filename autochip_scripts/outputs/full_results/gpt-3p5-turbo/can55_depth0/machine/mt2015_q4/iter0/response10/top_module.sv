module top_module(
	input x,
	input y,
	output z);

	// Define wire for internal connections
	wire a_first_gate, b_first_gate, a_second_gate, b_second_gate;

	// Instantiate the gates
	gate1 u1(
		.a(x),
		.b(y),
		.a_out(a_first_gate),
		.b_out(b_first_gate)
	);

	gate2 u2(
		.a(x),
		.b(y),
		.a_out(b_second_gate),
		.b_out(a_second_gate)
	);

	gate3 u3(
		.a(a_first_gate),
		.b(b_second_gate),
		.z(z)
	);

endmodule
module gate1(
	input a,
	input b,
	output a_out,
	output b_out
);

	// Define wire for internal connections
	wire and_out;

	// AND gate
	and_gate u1(
		.a(a),
		.b(b),
		.z(and_out)
	);

	// Assign outputs
	assign a_out = and_out;
	assign b_out = and_out;

endmodule
module gate2(
	input a,
	input b,
	output a_out,
	output b_out
);

	// Define wire for internal connections
	wire or_out;

	// OR gate
	or_gate u1(
		.a(a),
		.b(b),
		.z(or_out)
	);

	// Assign outputs
	assign a_out = b;
	assign b_out = a;

endmodule
module gate3(
	input a,
	input b,
	output z
);

	// Define wire for internal connection
	wire xor_out;

	// XOR gate
	xor_gate u1(
		.a(a),
		.b(b),
		.z(xor_out)
	);

	// Assign output
	assign z = xor_out;

endmodule
module and_gate(
	input a,
	input b,
	output z
);

	// AND gate
	assign z = a & b;

endmodule
module or_gate(
	input a,
	input b,
	output z
);

	// OR gate
	assign z = a | b;

endmodule
module xor_gate(
	input a,
	input b,
	output z
);

	// XOR gate
	assign z = a ^ b;

endmodule
