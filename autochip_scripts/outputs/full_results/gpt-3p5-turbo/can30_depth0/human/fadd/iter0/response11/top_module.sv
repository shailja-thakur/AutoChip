module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Wire declarations
	wire w1, w2, w3;

	// Instantiate the full adder sub-module
	full_adder FA(
		.a(a),
		.b(b),
		.cin(cin),
		.cout(w1),
		.sum(w2)
	);

	// Instantiate another full adder to handle the carry-out from the first adder
	full_adder FA2(
		.a(w2),
		.b(w3),
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

	// Wire declarations
	wire w1, w2, w3;

	// Intermediate signals for the sum and carry-out calculations
	xor U1(.a(a), .b(b), .z(w1));
	xor U2(.a(w1), .b(cin), .z(sum));
	and U3(.a(a),.b(b),.z(w3));

	// Carry propagation generation logic
	or U4(.a(cin), .b(w1), .cout(w2));
	and U5(.a(cin), .b(w1), .z(w4));
	and U6(.a(a), .b(b), .cout(w5));
	or U7(.a(w4), .b(w5), .cout(w6));
	and U8(.a(w2), .b(w6), .z(cout));
	
endmodule
