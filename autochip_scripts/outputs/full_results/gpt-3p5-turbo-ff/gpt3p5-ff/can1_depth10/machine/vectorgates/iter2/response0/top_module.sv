module top_module(
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output [7:0] out_or_logical,
  output [7:0] out_not
);

  // Bitwise OR operation
  assign out_or_bitwise = a | b;

  // Logical OR operation
  assign out_or_logical = (a != 0) || (b != 0);

  // Bitwise NOT operation
  assign out_not = ~a;

endmodule
