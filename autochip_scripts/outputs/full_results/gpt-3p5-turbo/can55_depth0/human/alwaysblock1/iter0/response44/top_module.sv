module top_module(
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);

  // Assign statement for AND gate
  assign out_assign = a & b;

  // Combinational always block for AND gate
  always @*
    out_alwaysblock = a & b;

endmodule
