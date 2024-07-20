module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire ab;

assign ab = c & ~d;

assign mux_in[0] = ab & (~c & ~d);
assign mux_in[1] = ab & (~c & d);
assign mux_in[2] = ab & (c & d);
assign mux_in[3] = ab & (c & ~d);

endmodule
