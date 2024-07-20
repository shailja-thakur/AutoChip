module top_module(
  input a,
  input b,
  output out
);

  reg out_reg;  // create a register to hold the value of the output

  // assign the value of out_reg to the logical negation of the logical OR of a and b
  assign out_reg = ~(a | b);

  // assign the value of out_reg to the output
  assign out = out_reg;

endmodule
