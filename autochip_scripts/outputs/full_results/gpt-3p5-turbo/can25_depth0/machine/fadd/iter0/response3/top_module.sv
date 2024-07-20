module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	assign {cout, sum} = a + b + cin;
	
	// set carry-out bit based on sum
	assign cout = (a + b + cin >= 2) ? 1 : 0;

endmodule
