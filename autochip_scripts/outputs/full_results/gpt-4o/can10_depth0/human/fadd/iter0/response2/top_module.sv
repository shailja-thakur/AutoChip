module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Intermediate signals
	wire sum_ab, carry1, carry2;

	// Sum of input bits
	assign sum_ab = a ^ b;
	assign sum = sum_ab ^ cin; 

	// Carry-out logic
	assign carry1 = a & b;
	assign carry2 = sum_ab & cin;
	assign cout = carry1 | carry2; 

endmodule
