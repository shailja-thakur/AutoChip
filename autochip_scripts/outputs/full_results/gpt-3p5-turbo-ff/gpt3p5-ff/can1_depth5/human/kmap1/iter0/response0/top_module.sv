module top_module(
  input a,
  input b,
  input c,
  output out
);
  
  wire w1, w2;
  
  and gate1(w1, a, c);
  and gate2(w2, b, c);
  
  or gate3(out, w1, w2);
    
endmodule
