module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);
	// Wire Declarations
	wire [2:0] a_inv, b_inv;

	// Inversion Module
	not_gate not_a0 (
		.in(a[0]),
		.out(a_inv[0])
	);
	
	not_gate not_a1 (
		.in(a[1]),
		.out(a_inv[1])
	);
	
	not_gate not_a2 (
		.in(a[2]),
		.out(a_inv[2])
	);
	
	not_gate not_b0 (
		.in(b[0]),
		.out(b_inv[0])
	);
	
	not_gate not_b1 (
		.in(b[1]),
		.out(b_inv[1])
	);
	
	not_gate not_b2 (
		.in(b[2]),
		.out(b_inv[2])
	);

	// Bitwise OR Module
	or_gate or0 (
		.in1(a),
		.in2(b),
		.out(out_or_bitwise)
	);

	// Logical OR Module
	or_gate or1 (
		.in1(|a),
		.in2(|b),
		.out(out_or_logical)
	);
	
	// Output assignment for out_not
	assign out_not = {b_inv, a_inv};

endmodule
module not_gate(
	input in,
	output out
);
	assign out = ~in;
endmodule
module or_gate(
	input [2:0] in1,
	input [2:0] in2,
	output [2:0] out
);
	assign out = in1 | in2;
endmodule
