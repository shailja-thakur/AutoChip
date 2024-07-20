module top_module (
	input signed [7:0] a,
	input signed [7:0] b,
	output signed [7:0] s,
	output overflow
);

	/* Adder */
	assign s = a + b;

	/* Overflow detection */
	assign overflow = (a[7] && b[7] && !s[7]) || (!a[7] && !b[7] && s[7]);

endmodule
