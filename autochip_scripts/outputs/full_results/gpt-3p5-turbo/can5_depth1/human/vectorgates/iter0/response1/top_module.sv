module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

	// Wire declarations
	wire [2:0] a_inverse;
	wire [2:0] b_inverse;
	
	// Bitwise OR module
	or_bitwise_module or_bitwise(
		.a(a),
		.b(b),
		.out_or_bitwise(out_or_bitwise)
	);
	
	// Logical OR module
	or_logical_module or_logical(
		.a(a),
		.b(b),
		.out_or_logical(out_or_logical)
	);
	
	// Inverter modules
	inverter_module inverter_a(
		.a(a),
		.out_inverse(a_inverse)
	);
	
	inverter_module inverter_b(
		.a(b),
		.out_inverse(b_inverse)
	);
	
	// Output assignment
	assign out_not = {b_inverse, a_inverse};
	
endmodule
module or_bitwise_module(
	input [2:0] a,
	input [2:0] b,
	output [2:0] out_or_bitwise
);
	
	// Bitwise OR assignment
	assign out_or_bitwise = a | b;
	
endmodule
module or_logical_module(
	input [2:0] a,
	input [2:0] b,
	output out_or_logical
);
	
	// Logical OR assignment
	assign out_or_logical = |(a | b);
	
endmodule
module inverter_module(
	input [2:0] a,
	output [2:0] out_inverse
);
	
	// Inverter assignment
	assign out_inverse = ~a;
	
endmodule
