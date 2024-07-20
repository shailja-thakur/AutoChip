module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n
);

wire and_out_1, and_out_2;

and(and_out_1, a, b);
and(and_out_2, c, d);

or(out, and_out_1, and_out_2);
not(out_n, out);

endmodule
