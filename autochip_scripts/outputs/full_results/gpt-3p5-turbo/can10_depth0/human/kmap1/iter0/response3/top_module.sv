module top_module(
  input a, 
  input b,
  input c,
  output out
);

  // Intermediate signals
  wire s;

  // Implementing the circuit logic
  assign s = (a & b) | (b & c);

  // Assigning the output
  assign out = s;

endmodule
