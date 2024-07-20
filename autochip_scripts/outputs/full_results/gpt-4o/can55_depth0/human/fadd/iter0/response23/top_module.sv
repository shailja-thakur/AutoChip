module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

    // Sum is the XOR of all three inputs
    assign sum = a ^ b ^ cin;
    
    // Carry-out is true if any two or more inputs are true
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
