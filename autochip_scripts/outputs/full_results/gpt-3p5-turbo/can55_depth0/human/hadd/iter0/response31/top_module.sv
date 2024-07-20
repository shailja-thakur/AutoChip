module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	
	// Define the internal signals
	wire s, c;

	// Instantiate the half adder
	half_adder HA_inst (
		.a(a),
		.b(b),
		.sum(s),
		.cout(c)
	);
	
	// Assign the output signals
	assign sum = s;
	assign cout = c;
	
endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);	
	
	// Define the internal signals
	wire s, c;

	// Implement the half adder logic
	xor_gate XOR_inst (
		.a(a),
		.b(b),
		.y(s)
	);
	and_gate AND_inst (
		.a(a),
		.b(b),
		.y(c)
	);
	
	// Assign the output signals
	assign sum = s;
	assign cout = c;
	
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
