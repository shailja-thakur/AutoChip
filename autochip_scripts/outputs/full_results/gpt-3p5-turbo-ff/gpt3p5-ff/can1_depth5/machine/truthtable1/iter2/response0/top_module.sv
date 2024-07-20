module top_module (
  input x3,
  input x2,
  input x1,
  output f
);
  
  // Declare intermediate signals
  wire a, b, c, d;
  
  // Implement the logic for output signal f
  or #(4) or1(f, a, b, c, d);
  
  // Internal signals
  not #(1) u1(a, x3);
  and #(1) u2(b, u1, x2);
  not #(1) u3(c, x1);
  and #(1) u4(d, x3, x2, x1);

endmodule
