module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Wire Declarations
	wire [2:0] not_a;
	wire [2:0] not_b;
	
	// Inverter Gates
	not_gate u_not_a(
		.in(a),
		.out(not_a)
	);
	
	not_gate u_not_b(
		.in(b),
		.out(not_b)
	);
	
	// Bitwise OR Calculation
	assign out_or_bitwise = a | b;
	
	// Logical OR Calculation
	assign out_or_logical = (a != 0) || (b != 0);
	
	// Assigning inverted values to out_not
	assign out_not[5:3] = not_b;
	assign out_not[2:0] = not_a;
	
endmodule
module not_gate(
	input [2:0] in,
	output [2:0] out
);

	assign out = ~in;
	
endmodule
