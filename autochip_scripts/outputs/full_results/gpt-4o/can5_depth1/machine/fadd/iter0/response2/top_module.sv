module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Calculating the sum and the carry-out bit
	assign {cout, sum} = a + b + cin;

endmodule
