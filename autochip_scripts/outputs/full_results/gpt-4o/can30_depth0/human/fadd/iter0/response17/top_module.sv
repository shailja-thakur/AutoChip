module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

    // sum is the XOR of a, b, and cin
    assign sum = a ^ b ^ cin;

    // carry-out is true if at least two of the three inputs are true
    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule
