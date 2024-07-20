module top_module (
  input a,
  input b,
  output sum,
  output cout
);

  // Instantiate the half adder module
  half_adder ha1 (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(cout)
  );

endmodule
module half_adder (
  input a,
  input b,
  output sum,
  output carry
);

  // Generate sum
  xor(sum, a, b);

  // Generate carry
  and(carry, a, b);

endmodule
