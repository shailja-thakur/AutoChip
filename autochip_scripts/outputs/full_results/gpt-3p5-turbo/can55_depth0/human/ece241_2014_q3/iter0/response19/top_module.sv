module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

wire mux_in_0, mux_in_1, mux_in_2, mux_in_3;

// Implementing the K-map using 2-to-1 muxes
assign mux_in_0 = (~c & ~d) | (c & ~d) | (c & d);
assign mux_in_1 = (~c & d) | (c & ~d);
assign mux_in_2 = c & d;
assign mux_in_3 = (c & ~d) | (~c & d) | (c & d);

// Implementing the 4-to-1 mux using a 3-to-1 mux and a 2-to-1 mux
wire ab0, ab1;
assign ab0 = 1'b0;
assign ab1 = 1'b0;

wire mux_in_1_0, mux_in_1_1, mux_in_2_0, mux_in_2_1, mux_in_3_0, mux_in_3_1;
assign mux_in_1_0 = mux_in_1;
assign mux_in_1_1 = mux_in_1;
assign mux_in_2_0 = mux_in_2;
assign mux_in_2_1 = mux_in_2;
assign mux_in_3_0 = mux_in_3;
assign mux_in_3_1 = mux_in_3;

wire mux_out;

mux_2to1 mux_1 (
  .a(ab0),
  .b(ab1),
  .sel(d),
  .out(mux_out)
);

mux_3to1 mux_2 (
  .a(mux_in_0),
  .b(mux_in_1_0),
  .c(mux_in_1_1),
  .sel(c),
  .out(mux_in[0])
);

mux_3to1 mux_3 (
  .a(mux_in_2_0),
  .b(mux_in_2_1),
  .c(mux_in_3_0),
  .sel(c),
  .out(mux_in[1])
);

mux_2to1 mux_4 (
  .a(mux_in_3_1),
  .b(mux_out),
  .sel(c),
  .out(mux_in[2])
);

mux_3to1 mux_5 (
  .a(mux_out),
  .b(mux_out),
  .c(mux_out),
  .sel(ab0),
  .out(mux_in[3])
);

endmodule
