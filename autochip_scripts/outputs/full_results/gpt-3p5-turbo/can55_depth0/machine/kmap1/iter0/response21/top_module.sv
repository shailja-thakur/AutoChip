module top_module(
  input a,
  input b,
  input c,
  output out
);
  // OR gate logic
  assign out = a | b | c;
endmodule
