module top_module (
  input a,
  input b,
  input sel,
  output out
);

  assign out = (sel == 0) ? a : b;

endmodule
