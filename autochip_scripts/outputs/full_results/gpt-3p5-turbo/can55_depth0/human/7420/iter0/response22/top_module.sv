module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire n1, n2, n3, n4, n5, n6, n7, n8;

  nand(n1, p1[0], p1[1], p1[2], p1[3]);
  nand(n2, p1[4], p1[5], p1[6], p1[7]);
  nand(n3, p2[0], p2[1], p2[2], p2[3]);
  nand(n4, p2[4], p2[5], p2[6], p2[7]);

  nand(n5, n1, n2);
  nand(n6, n3, n4);

  nand(n7, n5, n5);
  nand(n8, n6, n6);

  assign p1y = n7;
  assign p2y = n8;

endmodule
