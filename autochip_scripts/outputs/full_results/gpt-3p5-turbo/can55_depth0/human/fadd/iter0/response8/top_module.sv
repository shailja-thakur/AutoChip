module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

  wire s1, c1, c2;  // intermediate wires

  // First half adder
  xor gate1 (s1, a, b);
  and gate2 (c1, a, b);

  // Second half adder
  xor gate3 (sum, s1, cin);
  and gate4 (c2, s1, cin);

  // Final OR gate
  or gate5 (cout, c1, c2);

endmodule
