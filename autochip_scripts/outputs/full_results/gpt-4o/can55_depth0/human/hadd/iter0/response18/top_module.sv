module top_module (
	input a,
	input b,
	output sum,
	output cout
);
    assign sum = a ^ b; // Sum is the result of XOR of a and b
    assign cout = a & b; // Carry-out is the result of AND of a and b
endmodule
