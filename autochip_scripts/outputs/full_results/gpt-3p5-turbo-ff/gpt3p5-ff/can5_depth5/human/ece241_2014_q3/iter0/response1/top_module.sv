module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire w0, w1, w2, w3;

and g0(w0, c, ~d);
and g1(w1, c, d);
and g2(w2, ~c, ~d);
and g3(w3, c, ~d);

assign mux_in[0] = w3;
assign mux_in[1] = w0;
assign mux_in[2] = w2;
assign mux_in[3] = w1;

endmodule
