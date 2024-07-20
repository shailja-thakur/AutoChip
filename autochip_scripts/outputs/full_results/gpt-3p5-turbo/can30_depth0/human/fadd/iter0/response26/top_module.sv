module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal wires
	wire i1, i2, i3, i4, i5, i6;

	// Generate the sum
	xor gate1 (i1, a, b);
	xor gate2 (sum, i1, cin);

	// Generate the carry
	and gate3 (i2, a, b);
	and gate4 (i3, i1, cin);
	or gate5 (i4, i2, i3);
	xor gate6 (cout, i4, cin);

endmodule
