module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	
	// Use XOR gates to calculate the sum bit
	assign sum = a ^ b ^ cin;
	
	// Use AND and OR gates to calculate the carry-out bit
	assign cout = (a & b) | (cin & (a ^ b));
	
endmodule
