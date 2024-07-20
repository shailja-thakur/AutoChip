module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire declarations
	wire [7:0] sum;
	wire carry_out;
	
	// Adder
	full_adder adder (
		.a(a),
		.b(b),
		.sum(sum),
		.carry_out(carry_out)
	);

	// Output assignment
	assign s = sum;
	assign overflow = carry_out;
	
endmodule
module full_adder (
	input a,
	input b,
	input carry_in,
	output sum,
	output carry_out
);

	// Wire declarations
	wire s1, c1, c2;
	
	// Generate sum
	xor_gate xor1 (
		.a(a),
		.b(b),
		.y(s1)
	);
	
	xor_gate xor2 (
		.a(s1),
		.b(carry_in),
		.y(sum)
	);
	
	// Generate carry_out
	and_gate and1 (
		.a(a),
		.b(b),
		.y(c1)
	);
	
	and_gate and2 (
		.a(s1),
		.b(carry_in),
		.y(c2)
	);
	
	or_gate or1 (
		.a(c1),
		.b(c2),
		.y(carry_out)
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
