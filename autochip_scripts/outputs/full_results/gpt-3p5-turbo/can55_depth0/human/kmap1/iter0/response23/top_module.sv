module top_module(
  input a,
  input b,
  input c,
  output out
);

  wire d;
  
  and gate1(d, a, ~b, ~c);
  and gate2(out, a, b, c);
  
endmodule
