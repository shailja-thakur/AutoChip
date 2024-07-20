module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Define internal signals
	reg sum;
	reg cout;

	// Implement half adder logic
	assign sum = a ^ b;
	assign cout = a & b;

endmodule
