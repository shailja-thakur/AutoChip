module top_module (
    input x3,
    input x2,
    input x1,
    output f
);

  // Logic gate implementation
  wire condition1 = ~x3 & x2 & ~x1;
  wire condition2 = ~x3 & x2 & x1;
  wire condition3 = x3 & ~x2 & x1;
  wire condition4 = x3 & x2 & x1;

  // OR gate to combine the conditions
  assign f = condition1 | condition2 | condition3 | condition4;

endmodule
