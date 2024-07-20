module top_module (
  input a,
  input b,
  input c,
  input d,
  output out
);

  wire w1;
  wire w2;
  wire w3;
  wire w4;

  xor u1 (
    .a(a),
    .b(b),
    .out(w1)
  );

  xor u2 (
    .a(c),
    .b(d),
    .out(w2)
  );

  nor u3 (
    .a(w1),
    .b(w2),
    .out(w3)
  );

  xor u4 (
    .a(b),
    .b(c),
    .out(w4)
  );

  nor u5 (
    .a(a),
    .b(d),
    .out(out)
  );

  nor u6 (
    .a(w3),
    .b(w4),
    .out(out)
  );

endmodule
