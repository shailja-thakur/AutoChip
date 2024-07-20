module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire n1;
  wire n2;
  wire n3;
  wire n4;
  wire n5;
  wire n6;
  wire n7;
  wire n8;
  wire n9;
  wire n10;

  nand(n1, p1[0], p1[1], p1[2], p1[3]);
  nand(n2, p1[4], p1[5], p1[6], p1[7]);
  nand(n3, p2[0], p2[1], p2[2], p2[3]);
  nand(n4, p2[4], p2[5], p2[6], p2[7]);

  nand(n5, n1, n2);
  nand(n6, n3, n4);

  not(n7, n5);
  not(n8, n6);

  nand(n9, n5, n8);
  nand(n10, n6, n7);

  assign p1y = n9;
  assign p2y = n10;

endmodule
