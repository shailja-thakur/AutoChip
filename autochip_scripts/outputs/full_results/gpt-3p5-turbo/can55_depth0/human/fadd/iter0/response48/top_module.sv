module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Use assign statements to define the outputs
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (cin & (a ^ b));
endmodule
