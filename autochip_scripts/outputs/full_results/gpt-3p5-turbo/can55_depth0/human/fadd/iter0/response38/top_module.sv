module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Define internal signals
	wire s1, s2, s3;

	// Implement the full adder logic
	xor gate1 (s1, a, b);
	xor gate2 (sum, s1, cin);
	and gate3 (s2, a, b);
	and gate4 (s3, s1, cin);
	or gate5 (cout, s2, s3);

endmodule
