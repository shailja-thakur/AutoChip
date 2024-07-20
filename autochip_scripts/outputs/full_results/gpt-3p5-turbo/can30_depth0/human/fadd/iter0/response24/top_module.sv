module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Declare internal signals
	wire x, y, z;
	
	// Generate sum
	xor(x, a, b);
	xor(sum, x, cin);
	
	// Generate carry-out
	and(y, a, b);
	and(z, x, cin);
	or(cout, y, z);

endmodule
