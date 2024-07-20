module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Define internal wires
wire w1, w2, w3;

// Implement XOR gates for sum
assign w1 = a ^ b;
assign sum = w1 ^ cin;

// Implement AND gates for carry-out
assign w2 = a & b;
assign w3 = cin & w1;
assign cout = w2 | w3;

endmodule
