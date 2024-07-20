module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Internal signals
wire w1, w2, w3;

// Implement full adder logic
assign w1 = a ^ b;
assign sum = w1 ^ cin;
assign w2 = a & b;
assign w3 = w1 & cin;
assign cout = w2 | w3;

endmodule
