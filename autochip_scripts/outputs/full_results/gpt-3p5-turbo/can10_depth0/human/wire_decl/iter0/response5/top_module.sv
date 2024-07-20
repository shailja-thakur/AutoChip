module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;

	and gate1(intermediate1, a, b);
	and gate2(intermediate2, c, d);
	or gate3(out, intermediate1, intermediate2);
	not gate4(out_n, out);

endmodule
