module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Add your code here
	// Use internal wires if needed

	assign {cout, sum} = a + b + cin;

endmodule
