module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire not_c, not_d, not_b, not_a;
assign not_c = ~c;
assign not_d = ~d;
assign not_b = not_a;

assign mux_in[0] = not_c & not_d;
assign mux_in[1] = c & not_d;
assign mux_in[2] = c & d;
assign mux_in[3] = ~(c & d);

endmodule
