module top_module (
  input [2:0] a,
  input [2:0] b,
  input cin,
  output [2:0] cout,
  output [2:0] sum
);

  wire [2:0] s0, s1, s2;
  wire [2:0] c0, c1;

  full_adder fa0 (
    .a(a[0]),
    .b(b[0]),
    .cin(cin),
    .s(s0),
    .cout(c0)
  );

  full_adder fa1 (
    .a(s0),
    .b(b[1]),
    .cin(c0),
    .s(s1),
    .cout(c1)
  );

  full_adder fa2 (
    .a(s1),
    .b(b[2]),
    .cin(c1),
    .s(sum),
    .cout(cout)
  );

endmodule