module top_module (
	input a,
	input b,
	output sum,
	output cout
);

assign sum = a ^ b; // Sum is the XOR of the two inputs
assign cout = a & b; // Carry out is the AND of the two inputs

endmodule
