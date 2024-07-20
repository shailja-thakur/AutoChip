module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire w1, w2;
	and gate1 (w1, a, b);
	and gate2 (w2, c, d);
	or gate3 (out, w1, w2);
	not gate4 (out_n, out);

endmodule
module and (
	output reg o,
	input a,
	input b );

	always @ (*)
		o = a & b;

endmodule
module or (
	output reg o,
	input a,
	input b );

	always @ (*)
		o = a | b;

endmodule
module not (
	output reg o,
	input a );

	always @ (*)
		o = ~a;

endmodule
