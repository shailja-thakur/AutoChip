module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire ab_00;
wire ab_01;
wire ab_11;
wire ab_10;

and gate1 (ab_00, !c, !d);
and gate2 (ab_01, !c, d);
and gate3 (ab_11, c, d);
and gate4 (ab_10, c, !d);

assign mux_in[0] = ab_00;
assign mux_in[1] = ab_01;
assign mux_in[2] = ab_11;
assign mux_in[3] = ab_10;

endmodule
module and (
	output o,
	input a,
	input b
);

assign o = a & b;

endmodule
module or (
	output o,
	input a,
	input b
);

assign o = a | b;

endmodule
module not (
	output o,
	input a
);

assign o = !a;

endmodule
