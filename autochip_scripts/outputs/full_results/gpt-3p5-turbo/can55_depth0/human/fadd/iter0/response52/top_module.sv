module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Internal wires
  wire s1, s2;

  // XOR gates
  xor gate1 (s1, a, b);
  xor gate2 (sum, s1, cin);

  // AND gates
  and gate3 (s2, a, b);
  and gate4 (s3, cin, s1);
  and gate5 (cout, a, b, cin);

endmodule
