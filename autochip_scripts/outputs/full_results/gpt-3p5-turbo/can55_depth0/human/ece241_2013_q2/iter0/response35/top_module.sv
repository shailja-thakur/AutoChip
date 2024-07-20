module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  assign out_sop = (a == 0 && b == 1 && c == 1 && d == 1) || (a == 0 && b == 0 && c == 0 && d == 1) || (a == 1 && b == 1 && c == 1 && d == 1);
  assign out_pos = (a == 0 || b == 0 || c == 0 || d == 0) && (a == 1 || b == 1 || c == 1 || d == 1) && !(a == 0 && b == 1 && c == 1 && d == 1) && !(a == 0 && b == 0 && c == 0 && d == 1) && !(a == 1 && b == 1 && c == 1 && d == 1);

endmodule
