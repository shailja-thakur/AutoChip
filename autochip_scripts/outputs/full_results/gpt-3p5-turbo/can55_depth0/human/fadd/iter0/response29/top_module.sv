module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	
	// Implementing the full adder logic
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (cin & (a ^ b));
	
endmodule
