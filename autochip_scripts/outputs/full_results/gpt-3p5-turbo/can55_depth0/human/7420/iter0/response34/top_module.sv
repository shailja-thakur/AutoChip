module top_module (
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire [3:0] nand1;
  wire [3:0] nand2;

  assign nand1 = ~(p1[0] & p1[1] & p1[2] & p1[3]);
  assign nand2 = ~(p2[0] & p2[1] & p2[2] & p2[3]);

  assign p1y = ~(nand1[0] & nand1[1] & nand1[2] & nand1[3]);
  assign p2y = ~(nand2[0] & nand2[1] & nand2[2] & nand2[3]);

endmodule
