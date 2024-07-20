module top_module (
	input signed [7:0] a,
	input signed [7:0] b,
	output signed [7:0] s,
	output overflow
);

	always @* begin
		s = a + b;
		if ((a[7] == b[7]) && (s[7] != a[7])) // check for overflow condition
			overflow = 1;
		else
			overflow = 0;
	end

endmodule
