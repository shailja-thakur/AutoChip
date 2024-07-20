module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	
	// Instantiate the full adder module
	full_adder adder(
		.a(a),
		.b(b),
		.cin(cin),
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
	
	// Carry and sum bits
	wire s;
	wire c;
	
	// Generate sum bit
	xor_gate xor1(
		.a(a),
		.b(b),
		.y(s)
	);
	xor_gate xor2(
		.a(s),
		.b(cin),
		.y(sum)
	);
	
	// Generate carry-out bit
	and_gate and1(
		.a(a),
		.b(b),
		.y(carry1)
	);
	and_gate and2(
		.a(s),
		.b(cin),
		.y(carry2)
	);
	or_gate or1(
		.a(carry1),
		.b(carry2),
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
