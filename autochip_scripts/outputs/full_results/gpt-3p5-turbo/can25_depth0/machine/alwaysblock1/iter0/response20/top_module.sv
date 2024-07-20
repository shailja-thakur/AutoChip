module top_module(
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);

  // Here, the first output, out_assign, is generated using an assign statement,
  // which assigns the result of the logical AND operation between 'a' and 'b' to 'out_assign'.
  assign out_assign = a & b;

  // The second output, out_alwaysblock, is generated using an always block.
  always @*
    out_alwaysblock = a & b;

endmodule
