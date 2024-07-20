module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	/* Implement the half adder logic here */
	assign sum = a ^ b;
	assign cout = a & b;

endmodule
