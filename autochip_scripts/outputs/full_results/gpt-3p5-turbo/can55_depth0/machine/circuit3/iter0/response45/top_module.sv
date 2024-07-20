module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

wire ab_or;
wire cd_or;

or or1 (ab_or, a, b);
or or2 (cd_or, c, d);

and and1 (q, ab_or, cd_or);

endmodule
