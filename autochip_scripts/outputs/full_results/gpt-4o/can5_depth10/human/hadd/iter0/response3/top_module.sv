module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	assign sum = a ^ b; // Sum is the result of XORing the inputs
	assign cout = a & b; // Carry-out is the result of ANDing the inputs
endmodule
