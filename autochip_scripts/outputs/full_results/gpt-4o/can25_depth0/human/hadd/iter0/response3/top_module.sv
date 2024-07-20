module top_module (
	input a,
	input b,
	output sum,
	output cout
);

assign sum = a ^ b;  // XOR for sum
assign cout = a & b; // AND for carry-out

endmodule
