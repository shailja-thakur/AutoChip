module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Corrected code for the half adder:
	// Implementation of the sum and carry-out outputs.

	assign sum = a ^ b;    // XOR operation between inputs 'a' and 'b' for sum output.
	assign cout = a & b;   // AND operation between inputs 'a' and 'b' for carry-out output.
	
endmodule
