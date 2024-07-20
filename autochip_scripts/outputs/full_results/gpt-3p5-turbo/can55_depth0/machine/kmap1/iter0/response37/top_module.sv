module top_module(
  input a, 
  input b,
  input c,
  output out
);

  // Perform the OR operation on the inputs and assign the result to the output out
  assign out = a | b | c;

endmodule
