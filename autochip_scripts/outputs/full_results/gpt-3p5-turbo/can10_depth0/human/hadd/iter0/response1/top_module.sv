module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Internal wires
	wire s, c;
	
	// Instantiate the half adder module
	half_adder HA(
		.a(a),
		.b(b),
		.sum(s),
		.cout(c)
	);
	
	// Assign the outputs of the half adder to the top module outputs
	assign sum = s;
	assign cout = c;
	
endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);

	// Use bitwise XOR gate for sum and bitwise AND gate for carry-out
	assign sum = a ^ b;
	assign cout = a & b;
	
endmodule
