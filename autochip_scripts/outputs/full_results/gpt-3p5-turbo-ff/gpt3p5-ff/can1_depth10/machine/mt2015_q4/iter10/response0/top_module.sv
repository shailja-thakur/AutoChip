module top_module(
  input x,
  input y,
  output z
);

  wire a1, b1;

  // First gate - AND gate
  and_gate first_gate(
    .a(x),
    .b(y),
    .z(a1)
  );

  // Second gate - OR gate
  or_gate second_gate(
    .a(x),
    .b(y),
    .z(b1)
  );

  // Third gate - OR gate
  or_gate third_gate(
    .a(a1),
    .b(b1),
    .z(z)
  );

endmodule
module and_gate(
  input a,
  input b,
  output z
);

  assign z = a & b;

endmodule
module or_gate(
  input a,
  input b,
  output z
);

  assign z = a | b;

endmodule
