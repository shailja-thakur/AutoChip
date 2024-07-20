module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Intermediate signals
wire w0, w1, w2, w3, w4, w5, w6, w7;

// Implementing K-map using multiplexers
assign w0 = (~c & ~d);
assign w1 = (c & ~d);
assign w2 = (c & d);
assign w3 = (~c & d);

assign w4 = (w0 & ~a & ~b);
assign w5 = (w1 & a & ~b);
assign w6 = (w2 & a & b);
assign w7 = (w3 & ~a & b);

assign mux_in[0] = w4;
assign mux_in[1] = w5;
assign mux_in[2] = w6;
assign mux_in[3] = w7;

endmodule
