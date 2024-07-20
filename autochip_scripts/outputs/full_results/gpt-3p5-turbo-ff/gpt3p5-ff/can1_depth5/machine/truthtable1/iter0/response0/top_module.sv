module top_module (
  input x3,
  input x2,
  input x1,
  output f
);
  
  // Declare intermediate signals
  wire a, b, c, d;
  
  // Implement the logic for output signal f
  or #(.N(4)) or1(f, a, b, c, d);
  
  // Internal signals
  not u1(a, x3);
  and u2(b, u1, x2);
  not u3(c, x1);
  and u4(d, x3, x2, x1);

endmodule
