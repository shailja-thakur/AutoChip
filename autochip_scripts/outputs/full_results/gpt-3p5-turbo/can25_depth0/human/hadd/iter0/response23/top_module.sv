module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	
	// Define internal signals
	wire s;
	wire c;
	
	// Instantiate half adder
	half_adder ha1 (
		.a(a),
		.b(b),
		.s(s),
		.c(c)
	);
	
	// Assign outputs
	assign sum = s;
	assign cout = c;
	
endmodule
module half_adder (
	input a,
	input b,
	output s,
	output c
);
	
	// Implement XOR gate for sum
	xor_gate x1 (
		.a(a),
		.b(b),
		.y(s)
	);
	
	// Implement AND gate for carry
	and_gate a1 (
		.a(a),
		.b(b),
		.y(c)
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
