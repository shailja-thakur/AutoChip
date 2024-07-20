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
  not #(1) u1(.a(x3), .y(a));
  and #(1) u2(.a(u1), .b(x2), .y(b));
  not #(1) u3(.a(x1), .y(c));
  and #(1) u4(.a(x3), .b(x2), .c(x1), .y(d));

endmodule
