module top_module(
  input a,
  input b,
  output out
);

  // Logic for the output signal
  assign out = ~(a | b);

endmodule
