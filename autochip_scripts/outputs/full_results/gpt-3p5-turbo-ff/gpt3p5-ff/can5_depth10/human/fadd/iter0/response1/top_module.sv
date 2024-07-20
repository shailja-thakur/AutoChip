module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Implementation of the full adder logic
assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
