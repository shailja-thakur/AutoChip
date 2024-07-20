module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Logic for the full adder
	// Implementing sum and carry-out using XOR and AND gates
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (a & cin) | (b & cin);
	
endmodule
