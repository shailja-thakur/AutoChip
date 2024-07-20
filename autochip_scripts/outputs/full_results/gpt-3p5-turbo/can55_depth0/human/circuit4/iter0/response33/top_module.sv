module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
  // Declare internal wire signals
  wire x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16;
  
  // Logic gates
  xor #(1) u1 (.a(a), .b(b), .z(x1));
  xor #(1) u2 (.a(c), .b(d), .z(x2));
  xor #(1) u3 (.a(x1), .b(d), .z(x3));
  xor #(1) u4 (.a(a), .b(d), .z(x4));
  xor #(1) u5 (.a(a), .b(c), .z(x5));
  xor #(1) u6 (.a(a), .b(x2), .z(x6));
  xor #(1) u7 (.a(b), .b(c), .z(x7));
  xor #(1) u8 (.a(a), .b(b), .z(x8));

  and #(1) u9 (.a(x1), .b(x2), .z(x9));
  and #(1) u10 (.a(x2), .b(x3), .z(x10));
  and #(1) u11 (.a(x3), .b(x4), .z(x11));
  and #(1) u12 (.a(x4), .b(x5), .z(x12));
  and #(1) u13 (.a(x5), .b(x6), .z(x13));
  and #(1) u14 (.a(x6), .b(x7), .z(x14));
  and #(1) u15 (.a(x7), .b(x8), .z(x15));
  and #(1) u16 (.a(x8), .b(x9), .z(x16));

  // Output
  assign q = x16;
  
endmodule
