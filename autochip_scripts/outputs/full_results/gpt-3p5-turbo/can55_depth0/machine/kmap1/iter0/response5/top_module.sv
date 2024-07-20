module top_module(
  input a,
  input b,
  input c,
  output out
);

  // Assign the OR operation on the inputs to the output
  assign out = a || b || c;

endmodule
