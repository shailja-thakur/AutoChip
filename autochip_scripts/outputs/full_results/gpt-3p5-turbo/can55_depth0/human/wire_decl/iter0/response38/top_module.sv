module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate_1;
	wire intermediate_2;

	and gate_1(intermediate_1, a, b);
	and gate_2(intermediate_2, c, d);
	or gate_3(out, intermediate_1, intermediate_2);
	not gate_4(out_n, out);

endmodule
