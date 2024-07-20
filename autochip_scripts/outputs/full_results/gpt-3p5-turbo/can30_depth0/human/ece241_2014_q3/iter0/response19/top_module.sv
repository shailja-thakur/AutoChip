module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire not_c, not_d;
assign not_c = ~c;
assign not_d = ~d;

wire w1, w2, w3, w4, w5, w6;
assign w1 = not_c & not_d;
assign w2 = c & not_d;
assign w3 = c & d;
assign w4 = not_c & d;
assign w5 = w1 | w3;
assign w6 = w2 | w4;

mux4to1 mux_4to1 (
	.a(mux_in[0]),
	.b(mux_in[1]),
	.c(mux_in[2]),
	.d(mux_in[3]),
	.sel_a(a),
	.sel_b(b),
	.out(output_wire)
);

endmodule
module mux4to1 (
	input a,
	input b,
	input c,
	input d,
	input sel_a,
	input sel_b,
	output out
);
	
wire w7, w8;
assign w7 = sel_a & sel_b;
assign w8 = sel_a & ~sel_b;

wire not_a, not_b;
assign not_a = ~sel_a;
assign not_b = ~sel_b;

wire out_sel0, out_sel1, out_sel2, out_sel3;
assign out_sel0 = a & not_b & not_a;
assign out_sel1 = b & a & not_a;
assign out_sel2 = c & ~a & ~b;
assign out_sel3 = d & b & not_a;
assign out = out_sel0 | out_sel1 | out_sel2 | out_sel3;

mux2to1 mux_1 (
	.a(a),
	.b(b),
	.sel(sel_a),
	.out(mux_wire1)
);

mux2to1 mux_2 (
	.a(c),
	.b(d),
	.sel(not_a),
	.out(mux_wire2)
);

mux2to1 mux_3 (
	.a(mux_wire1),
	.b(mux_wire2),
	.sel(sel_b),
	.out(mux_wire3)
);

endmodule
module mux2to1 (
	input a,
	input b,
	input sel,
	output out
);

assign out = sel ? b : a;

endmodule
