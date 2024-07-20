module top_module(
  input a, 
  input b,
  output out
);
  not #(1) u1 (
    .a(a),
    .out(out1)
  );
  or #(2) u2 (
    .a(a),
    .b(b),
    .out(out2)
  );
  assign out = out1 & out2;
endmodule
