module top_module (
  input a, 
  input b,
  input c,
  input d,
  output out
);

  wire w1, w2, w3, w4, w5, w6;

  and gate1 (
    .in1(a),
    .in2(~b),
    .out(w1)
  );

  or gate2 (
    .in1(c),
    .in2(~d),
    .out(w2)
  );

  and gate3 (
    .in1(~a),
    .in2(b),
    .out(w3)
  );

  or gate4 (
    .in1(c),
    .in2(~d),
    .out(w4)
  );

  and gate5 (
    .in1(a),
    .in2(b),
    .out(w5)
  );

  and gate6 (
    .in1(~c),
    .in2(d),
    .out(w6)
  );

  or gate7 (
    .in1(w1),
    .in2(~w2),
    .in3(~w3),
    .in4(w4),
    .in5(w5),
    .in6(w6),
    .out(out)
  );

endmodule
