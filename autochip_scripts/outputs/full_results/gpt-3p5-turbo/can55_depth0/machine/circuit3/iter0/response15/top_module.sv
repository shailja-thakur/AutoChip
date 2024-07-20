module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
  // OR gates for input a and b
  wire ab_or;
  or (ab_or, a, b);

  // OR gates for input c and d
  wire cd_or;
  or (cd_or, c, d);

  // AND gate for the two OR outputs
  and (q, ab_or, cd_or);
endmodule
