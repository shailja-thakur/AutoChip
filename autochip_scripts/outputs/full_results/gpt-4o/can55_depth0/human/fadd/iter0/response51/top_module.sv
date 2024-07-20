module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

assign sum = a ^ b ^ cin; // Sum
assign cout = (a & b) | (b & cin) | (cin & a); // Carry-out

endmodule
