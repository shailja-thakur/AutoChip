module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Definitions for the K-map values
assign mux_in[0] = (c & !d) | (!c & d);
assign mux_in[1] = c & (!d | (c & d));
assign mux_in[2] = !c & d;
assign mux_in[3] = c | d;

endmodule
