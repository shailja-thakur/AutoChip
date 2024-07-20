module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
  wire q_internal;

  assign q_internal = ~((~(a & b) & c) | d);
  assign q = ~q_internal;
endmodule
