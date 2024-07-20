module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate_wire1;
	wire intermediate_wire2;

	and gate1 (a, b, intermediate_wire1);
	and gate2 (c, d, intermediate_wire2);

	or gate3 (intermediate_wire1, intermediate_wire2, out);
	not gate4 (out, out_n);

endmodule
