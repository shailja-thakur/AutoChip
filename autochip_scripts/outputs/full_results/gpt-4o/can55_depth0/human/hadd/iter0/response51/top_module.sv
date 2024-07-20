module top_module (
	input a,
	input b,
	output sum,
	output cout
);

    assign sum = a ^ b;  // XOR operation for the sum
    assign cout = a & b; // AND operation for the carry-out

endmodule
