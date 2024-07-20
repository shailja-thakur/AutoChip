module top_module (
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);
  wire [4:0] p1_nand, p2_nand;
  
  assign p1_nand = ~(p1[3:0] & p1[7:4]);
  assign p2_nand = ~(p2[3:0] & p2[7:4]);
  
  assign p1y = p1_nand[4];
  assign p2y = p2_nand[4];
  
endmodule
