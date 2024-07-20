module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal signals
	wire ab_sum;
	wire ab_cout;
	wire abc_sum;

	// Adding a and b
	assign ab_sum = a ^ b;
	assign ab_cout = a & b;

	// Adding ab_sum and cin
	assign abc_sum = ab_sum ^ cin;
	assign cout = ab_cout | (ab_sum & cin);
	assign sum = abc_sum;

endmodule
