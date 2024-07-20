module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// assign sum as bitwise XOR of inputs a and b
	assign sum = a ^ b;

	// assign cout as bitwise AND of inputs a and b
	assign cout = a & b;

endmodule
