module top_module(
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);

  assign out_or_bitwise = a | b;
  assign out_or_logical = |(a | b);
  assign out_not = ~a & 6'b111000 | ~b & 6'b000111;

endmodule
