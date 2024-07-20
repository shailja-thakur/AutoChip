module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Complete the module definition

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule
