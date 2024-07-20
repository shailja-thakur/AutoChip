module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal wires and registers declaration
	wire sum_wire;
	wire carry_out_wire;

	// Instance of the full adder module
	full_adder FA (
		.a(a),
		.b(b),
		.cin(cin),
		.cout(carry_out_wire),
		.sum(sum_wire)
	);

	// Assigning the output signals of the full adder module to top module output signals
	assign sum = sum_wire;
	assign cout = carry_out_wire;

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal wires declaration
	wire w1, w2, w3;

	// XOR gate for sum generation
	xor_gate XOR1 (
		.a(a),
		.b(b),
		.out(w1)
	);

	// XOR gate for carry-out generation
	xor_gate XOR2 (
		.a(w1),
		.b(cin),
		.out(sum)
	);

	// AND gate for carry-out generation
	and_gate AND1 (
		.a(a),
		.b(b),
		.out(w2)
	);

	// AND gate for carry-out generation
	and_gate AND2 (
		.a(cin), 
		.b(w1), 
		.out(w3)
	);

	// OR gate for carry-out generation
	or_gate OR1 (
		.a(w2),
		.b(w3),
		.out(cout)
	);

endmodule
module xor_gate (
	input a,
	input b,
	output out
);

	assign out = a ^ b;

endmodule
module and_gate (
	input a,
	input b,
	output out
);

	assign out = a & b;

endmodule
module or_gate (
	input a,
	input b,
	output out
);

	assign out = a | b;

endmodule
