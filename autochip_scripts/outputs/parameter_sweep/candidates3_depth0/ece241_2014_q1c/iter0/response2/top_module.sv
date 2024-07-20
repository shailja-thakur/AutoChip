module top_module (
  input signed [7:0] a,
  input signed [7:0] b,
  output signed [7:0] s,
  output overflow
);

  reg signed [8:0] sum;

  assign overflow = (sum[8] != sum[7]);

  always @(a, b)
    sum <= a + b;

  assign s = sum[7:0];

endmodule
