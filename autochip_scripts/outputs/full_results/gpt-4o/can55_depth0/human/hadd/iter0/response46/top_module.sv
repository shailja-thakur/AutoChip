module top_module (
	input a,
	input b,
	output sum,
	output cout
);

assign sum = a ^ b;   // XOR operation to produce the sum
assign cout = a & b;  // AND operation to produce the carry-out

endmodule
