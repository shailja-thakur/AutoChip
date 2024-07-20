module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1, intermediate2;

	and and1 (intermediate1, a, b);
	and and2 (intermediate2, c, d);
	or or1 (out, intermediate1, intermediate2);
	not not1 (out_n, out);

endmodule
module and (
	output out,
	input a,
	input b );

	assign out = a & b;

endmodule
module or (
	output out,
	input a,
	input b );

	assign out = a | b;

endmodule
module not (
	output out,
	input in );

	assign out = ~in;

endmodule
