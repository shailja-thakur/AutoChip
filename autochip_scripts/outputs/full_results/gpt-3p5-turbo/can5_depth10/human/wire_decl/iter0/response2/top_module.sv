module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire inter1;
	wire inter2;

	and gate1 (inter1, a, b);
	and gate2 (inter2, c, d);

	or gate3 (out, inter1, inter2);

	not gate4 (out_n, out);
endmodule
