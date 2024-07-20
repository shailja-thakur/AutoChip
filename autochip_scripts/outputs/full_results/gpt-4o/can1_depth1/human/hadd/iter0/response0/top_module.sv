module top_module (
	input a,
	input b,
	output sum,
	output cout
);

assign sum = a ^ b; // XOR operation to get the sum
assign cout = a & b; // AND operation to get the carry-out

endmodule
