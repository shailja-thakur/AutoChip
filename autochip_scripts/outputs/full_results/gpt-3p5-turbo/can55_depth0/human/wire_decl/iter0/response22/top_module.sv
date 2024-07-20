module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate1;
	wire intermediate2;

	and a1(intermediate1, a, b);
	and a2(intermediate2, c, d);
	or o1(out, intermediate1, intermediate2);
	not n1(out_n, out);

endmodule
module and (
	output wire out,
	input wire in1,
	input wire in2 );

	assign out = in1 & in2;

endmodule
module or (
	output wire out,
	input wire in1,
	input wire in2 );

	assign out = in1 | in2;

endmodule
module not (
	output wire out,
	input wire in );

	assign out = ~in;

endmodule
