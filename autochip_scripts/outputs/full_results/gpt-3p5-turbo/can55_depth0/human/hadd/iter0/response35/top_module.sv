module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Internal signals
	wire sum_int;
	wire cout_int;

	// Instantiate the half adder module
	half_adder HA(a, b, sum_int, cout_int);

	// Assign output signals
	assign sum = sum_int;
	assign cout = cout_int;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);

	// XOR gate for sum
	xor(sum, a, b);

	// AND gate for cout
	and(cout, a, b);

endmodule
