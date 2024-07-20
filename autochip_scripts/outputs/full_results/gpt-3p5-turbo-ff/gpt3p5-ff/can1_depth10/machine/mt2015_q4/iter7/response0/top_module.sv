module top_module(
  input x,
  input y,
  output z
);

  wire a1, b1, a2, b2;

  // First gate - AND gate
  and_gate first_gate(
    .a(x),
    .b(y),
    .z(a1)
  );

  // Second gate - XOR gate
  xor_gate second_gate(
    .a(y),
    .b(x),
    .z(a2)
  );

  // Third gate - XOR gate
  xor_gate third_gate(
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
module xor_gate(
  input a,
  input b,
  output z
);

  assign z = a ^ b;

endmodule
