module top_module (
  input [99:0] a,
  input [99:0] b,
  input cin,
  output [99:0] cout,
  output [99:0] sum
);

  reg [99:0] cout_i;
  reg [99:0] sum_i;

  full_adder fa0 (
    .a (a[99]),
    .b (b[99]),
    .cin (cin),
    .cout (cout_i[99]),
    .sum (sum_i[99])
  );

  for (int i = 98; i >= 0; i--) {
    full_adder fa (
      .a (a[i]),
      .b (b[i]),
      .cin (cout_i[i + 1]),
      .cout (cout_i[i]),
      .sum (sum_i[i])
    );
  }

  assign cout = cout_i[0];
  assign sum = sum_i[0];

endmodule