module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Wire declaration
	wire [2:0] inverse_a;
	wire [2:0] inverse_b;

	// Inverter modules for a and b
	not_gate not_a(
		.in(a),
		.out(inverse_a)
	);

	not_gate not_b(
		.in(b),
		.out(inverse_b)
	);

	// Bitwise OR module for a and b
	or_gate or_bitwise(
		.a(a),
		.b(b),
		.out(out_or_bitwise)
	);

	// Logical OR module for a and b
	or_gate or_logical(
		.a(|a),
		.b(|b),
		.out(out_or_logical)
	);

	// Assigning inverse of b to upper half of out_not
	assign out_not[5:3] = inverse_b;

	// Assigning inverse of a to lower half of out_not
	assign out_not[2:0] = inverse_a;

	// Inverter module definition
	module not_gate(
		input [2:0] in,
		output [2:0] out
	);
		assign out = ~in;
	endmodule
module or_gate(
		input [2:0] a,
		input [2:0] b,
		output [2:0] out
	);
		assign out = a | b;
	endmodule
