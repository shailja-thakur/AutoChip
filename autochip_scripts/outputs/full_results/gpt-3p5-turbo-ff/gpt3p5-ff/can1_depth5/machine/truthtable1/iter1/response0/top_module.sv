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
  not #(1) u1(.a(u1), .y(x3));
  and #(1) u2(.a(u2), .b(u1), .y(x2));
  not #(1) u3(.a(u3), .y(x1));
  and #(1) u4(.a(u4), .b(x3), .c(x2), .y(x1));

endmodule
