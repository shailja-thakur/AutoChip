module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal wire to hold the intermediate values
	wire sum_ab, cout_ab, cout_abc;

	// Half adder for inputs a and b
	assign sum_ab = a ^ b;
	assign cout_ab = a & b;

	// Half adder for sum_ab and carry-in
	assign sum = sum_ab ^ cin;
	assign cout_abc = sum_ab & cin;

	// Final carry-out
	assign cout = cout_ab | cout_abc;

endmodule
