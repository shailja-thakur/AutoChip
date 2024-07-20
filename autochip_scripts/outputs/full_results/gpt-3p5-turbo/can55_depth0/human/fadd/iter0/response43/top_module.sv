module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Declare internal signals
	wire w1, w2, w3;
	
	// Instantiate the full adder module
	full_adder fa1(
		.a(a),
		.b(b),
		.cin(cin),
		.cout(w1),
		.sum(w2)
	);
	
	// Instantiate the half adder module
	half_adder ha1(
		.a(w2),
		.b(w3),
		.cout(cout),
		.sum(sum)
	);
	
	// Instantiate the xor gate for w3
	xor_gate xor1(
		.a(a),
		.b(b),
		.y(w3)
	);
	
	// Instantiate the and gate for w1
	and_gate and1(
		.a(a),
		.b(b),
		.y(w1)
	);
	
endmodule
