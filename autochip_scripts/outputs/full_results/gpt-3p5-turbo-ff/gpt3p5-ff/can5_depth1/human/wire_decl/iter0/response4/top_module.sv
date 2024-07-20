module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate_1;
	wire intermediate_2;

	and_gate and_1 (a, b, intermediate_1);
	and_gate and_2 (c, d, intermediate_2);
	or_gate or_1 (intermediate_1, intermediate_2, out);
	not_gate not_1 (out, out_n);

endmodule
module and_gate (
	input a,
	input b,
	output y );

	assign y = a & b;

endmodule
module or_gate (
	input a,
	input b,
	output y );

	assign y = a | b;

endmodule
module not_gate (
	input a,
	output y );

	assign y = ~a;

endmodule
