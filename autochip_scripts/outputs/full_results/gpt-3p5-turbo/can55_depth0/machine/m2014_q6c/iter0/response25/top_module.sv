module top_module (
  input [6:1] y,
  input w,
  output reg Y2,
  output reg Y4
);

  // Assign Y2 the result of the AND operation between the first bit of y and the NOT of w
  assign Y2 = y[1] & ~w;

  // Assign Y4 the result of the AND operation between the second, third, fifth, and sixth bits of y and w
  assign Y4 = y[2] & y[3] & y[5] & y[6] & w;

endmodule
