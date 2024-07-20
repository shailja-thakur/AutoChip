module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

  wire w0, w1, w2;

  // Implementing the K-map using 2-to-1 multiplexers
  
  mux2to1 mux0 (
    .a(c),
    .b(d),
    .sel(a[1]),
    .out(w0)
  );

  mux2to1 mux1 (
    .a(c),
    .b(d),
    .sel(a[0]),
    .out(w1)
  );

  mux2to1 mux2 (
    .a(c),
    .b(d),
    .sel(b[1]),
    .out(w2)
  );

  mux2to1 mux3 (
    .a(c),
    .b(d),
    .sel(b[0]),
    .out(mux_in[0])
  );

  // Connecting the outputs of the 2-to-1 multiplexers to the 4-to-1 multiplexer

  mux4to1 mux4 (
    .a(w0),
    .b(mux_in[0]),
    .c(w1),
    .d(w2),
    .sel({a[1], a[0]}),
    .out(mux_in[1])
  );

endmodule
