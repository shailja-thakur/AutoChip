module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Internal wire declaration
	wire w1, w2, w3;

	// Instantiate the full adder
	full_adder FA1 (
		.a(a),
		.b(b),
		.cin(cin),
		.cout(w1),
		.sum(w2)
	);

	// Instantiate another full adder with carry-in connected to the carry-out of previous full adder
	full_adder FA2 (
		.a(w2),
		.b(w1),
		.cin(1'b0),
		.cout(cout),
		.sum(sum)
	);
endmodule
