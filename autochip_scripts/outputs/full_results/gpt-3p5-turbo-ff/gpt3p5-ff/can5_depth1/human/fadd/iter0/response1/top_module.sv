module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Assign outputs using internal signals
wire w1, w2, w3;

// Instantiate the full adder module
full_adder FA1(
	.a(a),
	.b(b),
	.cin(cin),
	.cout(w1),
	.sum(w2)
);

// Instantiate another full adder for the carry out
full_adder FA2(
	.a(w2),
	.b(cin),
	.cin(w1),
	.cout(cout),
	.sum(sum)
);

// Define the full adder module
module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Internal wires for intermediate calculations
wire w1, w2, w3;

// Use xor gates to calculate sum
xor_gate XOR1(
	.a(a),
	.b(b),
	.y(w1)
);
xor_gate XOR2(
	.a(w1),
	.b(cin),
	.y(sum)
);

// Use and gates and xor gates to calculate carry out
and_gate AND1(
	.a(a),
	.b(b),
	.y(w2)
);
and_gate AND2(
	.a(w1),
	.b(cin),
	.y(w3)
);
or_gate OR(
	.a(w2),
	.b(w3),
	.y(cout)
);

endmodule
module xor_gate (
	input a,
	input b,
	output y
);

assign y = a ^ b;

endmodule
module and_gate (
	input a,
	input b,
	output y
);

assign y = a & b;

endmodule
module or_gate (
	input a,
	input b,
	output y
);

assign y = a | b;

endmodule
