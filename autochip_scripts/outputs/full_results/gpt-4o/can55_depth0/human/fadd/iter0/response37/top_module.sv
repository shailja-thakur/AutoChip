module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

    assign sum = a ^ b ^ cin;  // Sum is the XOR of a, b, and cin
    assign cout = (a & b) | (b & cin) | (a & cin);  // Cout is the carry-out of a full adder

endmodule
