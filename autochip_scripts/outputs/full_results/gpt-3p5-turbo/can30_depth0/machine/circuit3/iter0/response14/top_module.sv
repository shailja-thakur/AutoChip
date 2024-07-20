module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

wire or1_out;
wire or2_out;

or or1 (a, b, or1_out);
or or2 (c, d, or2_out);
and (or1_out, or2_out, q);

endmodule
