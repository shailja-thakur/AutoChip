module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Internal wires
  wire s1, s2, c_out;

  // Instantiate the full adder
  full_adder FA1 (
    .a(a),
    .b(b),
    .ci(cin),
    .co(c_out),
    .sum(s1)
  );

  full_adder FA2 (
    .a(s1),
    .b(cin),
    .ci(c_out),
    .co(cout),
    .sum(sum)
  );

endmodule
