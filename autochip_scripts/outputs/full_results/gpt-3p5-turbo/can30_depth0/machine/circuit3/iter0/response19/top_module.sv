module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);

  wire ab_or, cd_or;

  // Bitwise OR gate for a and b
  assign ab_or = a | b;

  // Bitwise OR gate for c and d
  assign cd_or = c | d;

  // Bitwise AND gate for ab_or and cd_or
  assign q = ab_or & cd_or;

endmodule
