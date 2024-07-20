module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	/* Complete the module with the logic for calculating cout and sum */
	assign {cout, sum} = a + b + cin;

endmodule
