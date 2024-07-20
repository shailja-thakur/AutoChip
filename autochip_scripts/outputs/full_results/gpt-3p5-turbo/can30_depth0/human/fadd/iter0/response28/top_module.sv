module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Define internal wires and variables
	wire s1, c1, c2;
	
	// Implement XOR gates for sum
	assign s1 = a ^ b;
	assign sum = s1 ^ cin;
	
	// Implement AND gates for carry out
	assign c1 = a & b;
	assign c2 = s1 & cin;
	assign cout = c1 | c2;
	
endmodule
