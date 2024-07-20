module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire w1, w2, w3;

assign mux_in[0] = 1;
assign mux_in[1] = c;
assign w1 = d;
assign w2 = c;
assign w3 = d;
assign mux_in[2] = (w1 & w2) | (w2 & w3);
assign mux_in[3] = (c & d) | (~c & d);

endmodule
