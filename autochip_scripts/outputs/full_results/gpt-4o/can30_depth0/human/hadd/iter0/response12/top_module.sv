module top_module (
	input a,
	input b,
	output sum,
	output cout
);

assign sum = a ^ b;  // Sum is the result of XOR between a and b
assign cout = a & b;  // Carry-out is the result of AND between a and b

endmodule
