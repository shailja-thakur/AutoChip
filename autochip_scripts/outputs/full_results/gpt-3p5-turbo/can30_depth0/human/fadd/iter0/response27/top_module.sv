module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Internal wires
  wire s1, s2, s3;

  // Instantiating the full adder logic

  full_adder fa1 (
    .a(a),
    .b(b),
    .cin(cin),
    .cout(s2),
    .sum(s1)
  );

  full_adder fa2 (
    .a(s1),
    .b(s2),
    .cin(s3),
    .cout(cout),
    .sum(sum)
  );

endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  assign {cout, sum} = a + b + cin;

endmodule
