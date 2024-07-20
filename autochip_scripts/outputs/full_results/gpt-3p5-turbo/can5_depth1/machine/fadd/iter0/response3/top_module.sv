module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	assign {cout, sum} = a + b + cin; // calculate the sum and carry out
	
	assign cout = (a + b + cin) >= 2; // calculate the carry out

endmodule
