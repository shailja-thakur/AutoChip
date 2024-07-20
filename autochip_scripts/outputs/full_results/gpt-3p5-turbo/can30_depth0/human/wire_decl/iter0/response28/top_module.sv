module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire wire1;
	wire wire2;

	and gate1(wire1, a, b);
	and gate2(wire2, c, d);
	or gate3(out, wire1, wire2);
	not gate4(out_n, out);
	
endmodule
