module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Define the architecture of the half adder
	assign sum = a ^ b;		// XOR operation to calculate the sum
	assign cout = a & b;	// AND operation to calculate the carry-out

endmodule
