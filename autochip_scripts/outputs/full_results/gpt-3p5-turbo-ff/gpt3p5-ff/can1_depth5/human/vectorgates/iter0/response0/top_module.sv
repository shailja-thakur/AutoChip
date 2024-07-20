module top_module(
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);

  wire [2:0] a_inv = ~a;
  wire [2:0] b_inv = ~b;

  assign out_or_bitwise = a | b;
  assign out_or_logical = a_inv | b_inv;
  assign out_not[5:3] = b_inv;
  assign out_not[2:0] = a_inv;

endmodule
