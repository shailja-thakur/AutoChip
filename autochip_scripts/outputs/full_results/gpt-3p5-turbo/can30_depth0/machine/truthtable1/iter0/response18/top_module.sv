module top_module (
  input x3,
  input x2,
  input x1,
  output f
);

// Signal declarations
wire w1, w2, w3, w4;

// Intermediate signals
and g1(w1, x3, ~x2, ~x1);
and g2(w2, ~x3, x2, ~x1);
and g3(w3, ~x3, x2, x1);
and g4(w4, x3, x2, x1);

// Output signal
or o1(f, w1, w2, w3, w4);

endmodule
