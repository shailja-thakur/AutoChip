module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Declare internal wire for carry generation
	wire carry1;

	// Declare internal wires for sum generation
	wire sum1;
	wire sum2;
	
	// Generate sum of a and b
	xor(sum1, a, b);
	
	// Generate carry
	and(carry1, a, b);

	// Generate sum of cin and sum1
	xor(sum2, sum1, cin);

	// Generate carry-out
	or(cout, carry1, sum1);

	// Assign outputs
	assign sum = sum2;

endmodule
