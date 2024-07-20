module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal signals
	wire x1, y1;
	
	// Instantiate half-adder
	half_adder ha_inst (
		.a(a),
		.b(b),
		.sum(x1),
		.cout(y1)
	);
	
	// Output connections
	assign sum = x1;
	assign cout = y1;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);
	
	// Logic to calculate sum and carry-out
	assign sum = a ^ b;
	assign cout = a & b;

endmodule
