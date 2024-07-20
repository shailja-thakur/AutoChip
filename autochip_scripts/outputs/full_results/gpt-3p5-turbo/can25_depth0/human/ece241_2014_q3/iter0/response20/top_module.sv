module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

wire w0, w1, w2, w3;

and #(4) and0(w0, c, d, ~d);
and #(4) and1(w1, c, d, ~c);
and #(4) and2(w2, c, d, d);
and #(4) and3(w3, c, d, ~c, d);

assign mux_in[0] = w0;
assign mux_in[1] = w1;
assign mux_in[2] = w2;
assign mux_in[3] = w3;

endmodule
