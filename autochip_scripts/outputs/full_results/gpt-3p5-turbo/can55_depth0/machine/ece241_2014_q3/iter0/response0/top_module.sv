module top_module (
  input c,
  input d,
  output [3:0] mux_in
);

  assign mux_in[0] = c | d;    // First bit of mux_in is assigned to the logical OR of inputs c and d
  assign mux_in[1] = 0;        // Second bit of mux_in is assigned 0
  assign mux_in[2] = ~d;       // Third bit of mux_in is assigned to the logical NOT of input d
  assign mux_in[3] = c & d;    // Fourth bit of mux_in is assigned to the logical AND of inputs c and d

endmodule
