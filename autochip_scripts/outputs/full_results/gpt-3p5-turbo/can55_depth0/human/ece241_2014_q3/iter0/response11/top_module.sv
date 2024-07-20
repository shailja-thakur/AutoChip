module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

  wire ab_00 = ~(c & d);
  wire ab_01 = c & ~d;
  wire ab_11 = c & d;
  wire ab_10 = ~c & d;
  
  assign mux_in[0] = ab_00;
  assign mux_in[1] = ab_01;
  assign mux_in[2] = ab_11;
  assign mux_in[3] = ab_10;
  
endmodule
