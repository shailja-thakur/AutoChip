module top_module (
  input c,
  input d,
  output [3:0] mux_in
);
  
  wire w0, w1, w2, w3, w4, w5, w6, w7;
  
  and gate1 (w0, c, d);
  and gate2 (w1, c, d);
  and gate3 (w2, c, d);
  and gate4 (w3, c, d);
  and gate5 (w4, c, d);
  and gate6 (w5, c, d);
  and gate7 (w6, c, d);
  and gate8 (w7, c, d);
  
  assign mux_in[0] = ~(~w0 & ~d);
  assign mux_in[1] = ~(d & ~c);
  assign mux_in[2] = ~(w2 & ~c);
  assign mux_in[3] = ~(w3 & ~w4 & c);
  
endmodule
