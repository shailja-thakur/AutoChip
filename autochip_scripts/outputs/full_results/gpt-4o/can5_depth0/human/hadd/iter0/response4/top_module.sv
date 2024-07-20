module top_module (
	input a,
	input b,
	output sum,
	output cout
);

assign sum = a ^ b; // Sum is a XOR b
assign cout = a & b; // Carry-out is a AND b

endmodule
