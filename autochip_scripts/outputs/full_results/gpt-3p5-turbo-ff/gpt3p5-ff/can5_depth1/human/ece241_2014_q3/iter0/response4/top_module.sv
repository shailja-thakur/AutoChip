module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire not_c, not_d;

not_1 not_c_gate (c, not_c);
not_2 not_d_gate (d, not_d);

and_1 and_cd_gate (c, d, mux_in[0]);
and_2 and_cd_not_gate (c, not_d, mux_in[1]);
and_3 and_c_not_d_gate (not_c, d, mux_in[2]);
and_4 and_not_c_not_d_gate (not_c, not_d, mux_in[3]);

endmodule
