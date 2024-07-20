module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

    assign sum = a ^ b ^ cin;            // Sum is the result of a XOR b XOR cin
    assign cout = (a & b) | (b & cin) | (a & cin); // Carry out is generated if any two or more inputs are 1

endmodule
