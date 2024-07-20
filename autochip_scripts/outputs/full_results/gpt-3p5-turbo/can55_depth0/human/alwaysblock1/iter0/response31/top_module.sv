module top_module (
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);

  // Assign statement for the AND gate
  assign out_assign = a & b;

  // Combinational always block for the AND gate
  always @*
    out_alwaysblock = a & b;

endmodule
