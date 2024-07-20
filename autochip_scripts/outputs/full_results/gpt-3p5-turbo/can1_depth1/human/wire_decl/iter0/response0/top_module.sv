module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

	wire intermediate_1;
	wire intermediate_2;

	and u1 (intermediate_1, a, b);
	and u2 (intermediate_2, c, d);
	or  u3 (out, intermediate_1, intermediate_2);
	not u4 (out_n, out);

endmodule
module and (
	input a,
	input b,
	output y );

	assign y = a & b;

endmodule
module or (
	input a,
	input b,
	output y );

	assign y = a | b;

endmodule
module not (
	input a,
	output y );

	assign y = !a;

endmodule
