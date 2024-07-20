module top_module (
	input a,
	input b,
	output sum,
	output cout
);

assign sum = a ^ b;   // Sum is the XOR of inputs a and b
assign cout = a & b;  // Carry-out is the AND of inputs a and b

endmodule
