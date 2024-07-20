module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;

	and_gate and1(a, b, intermediate1);
	and_gate and2(c, d, intermediate2);
	or_gate or1(intermediate1, intermediate2, out);
	not_gate not1(out, out_n);

endmodule
