module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	// Implementing the adder functionality using assign statement
	assign sum = a + b;
	assign cout = a & b;
endmodule
