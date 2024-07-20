module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire and1_output;
	wire and2_output;

	and_gate and1(a, b, and1_output);
	and_gate and2(c, d, and2_output);

	or_gate or1(and1_output, and2_output, out);
	not_gate not1(out, out_n);

endmodule
