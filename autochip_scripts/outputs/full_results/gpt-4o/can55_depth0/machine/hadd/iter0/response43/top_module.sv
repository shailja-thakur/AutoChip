module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	// Use wire to hold the carry bit
	wire carry;

	// Perform bitwise addition
	assign {cout, sum} = a + b;

endmodule
