module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire w1, w2, w3, w4, w5, w6, w7, w8;

// Implementing the K-map using 2-to-1 multiplexers
assign mux_in[0] = (c & ~d) ? 0 : 1;
assign mux_in[1] = (c & ~d) ? 1 : 0;
assign mux_in[2] = (c & d) ? 0 : 1;
assign mux_in[3] = (c & ~d) ? 0 : 1;

// Implementing the 4-to-1 multiplexer
assign mux_in = (_a & _b) ? mux_in[3:0] : mux_in[0:3];

endmodule
