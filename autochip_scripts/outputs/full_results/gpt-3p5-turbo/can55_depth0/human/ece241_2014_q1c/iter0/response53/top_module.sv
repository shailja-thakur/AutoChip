module top_module (
	input signed [7:0] a,
	input signed [7:0] b,
	output signed [7:0] s,
	output overflow
);

	assign s = a + b;
	assign overflow = (a[7] && b[7] && ~s[7]) || (~a[7] && ~b[7] && s[7]);

endmodule
