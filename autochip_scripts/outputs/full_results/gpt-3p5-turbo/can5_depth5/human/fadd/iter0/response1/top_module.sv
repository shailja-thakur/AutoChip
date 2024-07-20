module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Internal signals
wire w1, w2, w3;

// Instantiate the full adder
full_adder FA1 (
	.a(a),
	.b(b),
	.cin(cin),
	.cout(w1),
	.sum(w2)
);

// Instantiate another full adder to add the carry-out of the previous adder with cin
full_adder FA2 (
	.a(w1),
	.b(cin),
	.cin(w1),
	.cout(cout),
	.sum(sum)
);

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Internal signals
wire w1, w2, w3;

// XOR gate to calculate the sum
xor_gate XOR1 (
	.a(a),
	.b(b),
	.out(w1)
);

// XOR gate to calculate the carry-out
xor_gate XOR2 (
	.a(w1),
	.b(cin),
	.out(sum)
);

// AND gate to calculate the carry-out
and_gate AND1 (
	.a(a),
	.b(b),
	.out(w2)
);

// AND gate to calculate the carry-in
and_gate AND2 (
	.a(w1),
	.b(cin),
	.out(w3)
);

// OR gate to calculate the carry-out
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
