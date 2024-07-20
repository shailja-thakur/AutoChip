module top_module (
	input a,
	input b,
	output sum,
	output cout
);

// Declare internal wire for carry out
wire carry_out;

// Assign statements for sum and carry out
assign sum = a + b;
assign cout = carry_out;

endmodule
