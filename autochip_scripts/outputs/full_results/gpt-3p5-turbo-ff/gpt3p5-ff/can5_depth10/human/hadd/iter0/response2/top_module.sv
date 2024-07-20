module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wires
	wire w1, w2;
	
	// Assign the internal wires
	assign w1 = a & b;
	assign w2 = a ^ b;
	
	// Output the sum and carry-out
	assign sum = w2;
	assign cout = w1;	
	
endmodule
