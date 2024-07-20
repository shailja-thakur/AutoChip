module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

wire w1, w2, w3, w4;

assign w1 = ~c & ~d;
assign w2 = c & ~d;
assign w3 = ~c & d;
assign w4 = c & d;

assign mux_in[0] = w4;
assign mux_in[1] = w1;
assign mux_in[2] = w2;
assign mux_in[3] = w1 | w3;

endmodule
