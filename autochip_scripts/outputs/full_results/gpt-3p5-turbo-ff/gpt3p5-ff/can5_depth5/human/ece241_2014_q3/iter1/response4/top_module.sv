module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

  wire a, b;
  wire ab_00, ab_01, ab_11, ab_10;

  assign a = 1'b0;
  assign b = 1'b1;

  assign ab_00 = ~a & ~b;
  assign ab_01 = ~a & b;
  assign ab_11 = a & b;
  assign ab_10 = a & ~b;

  assign mux_in[0] = (ab_00 & ~c & ~d) | (ab_01 & ~c & d) | (ab_11 & c & ~d) | (ab_10 & c & d);
  assign mux_in[1] = (ab_00 & ~c & ~d) | (ab_01 & ~c & ~d) | (ab_11 & c & ~d) | (ab_10 & ~c & d);
  assign mux_in[2] = (ab_00 & ~c & ~d) | (ab_01 & c & ~d) | (ab_11 & c & d) | (ab_10 & ~c & ~d);
  assign mux_in[3] = (ab_00 & ~c & d) | (ab_01 & c & d) | (ab_11 & c & d) | (ab_10 & c & ~d);

endmodule
