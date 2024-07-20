module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// logic to compute sum
assign sum = a ^ b ^ cin;

// logic to compute carry-out
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
