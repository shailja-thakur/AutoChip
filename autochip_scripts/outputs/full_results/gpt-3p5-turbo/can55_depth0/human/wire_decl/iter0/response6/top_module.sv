module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;

	and gate_and1 (intermediate1, a, b);
	and gate_and2 (intermediate2, c, d);
	or gate_or (out, intermediate1, intermediate2);
	not gate_not (out_n, out);

endmodule
