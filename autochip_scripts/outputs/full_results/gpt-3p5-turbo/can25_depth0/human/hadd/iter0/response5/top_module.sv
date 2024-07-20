module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wires for sum and carry out
	wire sum_w;
	wire cout_w;
	
	// Instantiate the half adder module
	half_adder half_adder_inst (
		.a(a),
		.b(b),
		.sum(sum_w),
		.cout(cout_w)
	);
	
	// Assign the output wires to the module outputs
	assign sum = sum_w;
	assign cout = cout_w;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);

	// Generate the sum and carry out
	assign sum = a ^ b;
	assign cout = a & b;

endmodule
