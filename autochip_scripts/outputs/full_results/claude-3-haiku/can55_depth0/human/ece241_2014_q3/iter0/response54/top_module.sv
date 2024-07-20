module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire s0, s1;

// Implement the K-map using 2-to-1 multiplexers
assign s0 = (c & ~d) | (~c & d);
assign s1 = (c & d) | (c & ~d) | (~c & d);

assign mux_in[0] = 1;
assign mux_in[1] = s0;
assign mux_in[2] = s1;
assign mux_in[3] = (c & d) | (~c & d) | (c & ~d);

endmodule
