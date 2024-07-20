module top_module(
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);

  // using assign statement
  assign out_assign = a & b;

  // using combinational always block
  always @*
    out_alwaysblock = a & b;
  
endmodule
