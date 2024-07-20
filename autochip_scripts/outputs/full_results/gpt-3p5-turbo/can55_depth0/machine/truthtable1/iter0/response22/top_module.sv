module top_module (
  input x3,
  input x2,
  input x1,
  output f
);

  /* Define internal signals */
  wire y1, y2, y3, y4;

  /* Implement the combination logic */
  assign y1 = ~x3 & x2 & ~x1;
  assign y2 = ~x3 & x2 & x1;
  assign y3 = x3 & ~x2 & x1;
  assign y4 = x3 & x2 & x1;

  /* Combine the internal signals using logical OR operation */
  assign f = y1 | y2 | y3 | y4;

endmodule
