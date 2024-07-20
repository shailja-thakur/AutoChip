module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	// Implement the half adder logic here
	// Output the sum and carry-out
	// Use xor gate for sum and and gate for carry-out
	assign sum = a ^ b;
	assign cout = a & b;
endmodule
