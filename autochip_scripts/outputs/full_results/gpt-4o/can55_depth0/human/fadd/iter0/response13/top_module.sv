module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

    assign sum = a ^ b ^ cin;        // Sum is xor of all three inputs
    assign cout = (a & b) | (b & cin) | (cin & a);  // Carry-out is true if any two or more inputs are true

endmodule
