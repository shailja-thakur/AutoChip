module top_module(
  input a,
  input b,
  input c,
  output out
);

  assign out = a | b | c; // Perform logical OR operation on inputs

endmodule
