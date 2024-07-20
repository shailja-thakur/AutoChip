module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate_1;
	wire intermediate_2;
	
	and gate_1 (a, b, intermediate_1);
	and gate_2 (c, d, intermediate_2);
	or gate_3 (intermediate_1, intermediate_2, out);
	not gate_4 (out, out_n);

endmodule
