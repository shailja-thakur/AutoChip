module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

wire ab_or, cd_or;

or(A, ab_or, a, b);
or(B, cd_or, c, d);
and(q, ab_or, cd_or);
endmodule
