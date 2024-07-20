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
  not #(1) u1(u1, a);
  and #(1) u2(u2, u1, x2);
  not #(1) u3(u3, x1);
  and #(1) u4(u4, x3, x2, x1);

endmodule
module or #(parameter N=2) (
  output reg out,
  input [N-1:0] in
);
  always @*
    out = |in;
endmodule
module not #(parameter N=1) (
  input [N-1:0] a,
  output reg [N-1:0] y
);
  always @*
    y = ~a;
endmodule
module and #(parameter N=2) (
  output reg out,
  input [N-1:0] a,
  input [N-1:0] b
);
  always @*
    out = &a&b;
endmodule
