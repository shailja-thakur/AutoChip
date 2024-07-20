module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;
	and and1 (a, b, intermediate1);
	and and2 (c, d, intermediate2);
	or or_gate (intermediate1, intermediate2, out);
	not not_gate (out, out_n);

endmodule
