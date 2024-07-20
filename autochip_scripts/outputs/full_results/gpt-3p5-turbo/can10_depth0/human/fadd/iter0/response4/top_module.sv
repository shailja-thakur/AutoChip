module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// create intermediate signals for easier readability
reg sum_reg, cout_reg;

// create logic for sum
assign sum = a ^ b ^ cin;

// create logic for carry out
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
