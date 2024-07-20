module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  reg a_or_b;
  reg c_or_d;

  always @(a, b)
    a_or_b = a | b;

  always @(c, d)
    c_or_d = c | d;

  always @(a_or_b, c_or_d)
    q = a_or_b & c_or_d;

endmodule
