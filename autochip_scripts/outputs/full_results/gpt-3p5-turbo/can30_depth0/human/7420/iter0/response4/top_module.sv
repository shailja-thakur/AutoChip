module top_module (
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  output p1y,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p2y
);

  wire w1, w2, w3, w4;

  nand n1 (w1, p1a, p1b, p1c, p1d);
  nand n2 (w2, p2a, p2b, p2c, p2d);

  nand n3 (p1y, w1, w1);
  nand n4 (p2y, w2, w2);

endmodule
module nand (
  output out,
  input in1,
  input in2,
  input in3,
  input in4
);
  assign out = ~(in1 & in2 & in3 & in4);
endmodule
