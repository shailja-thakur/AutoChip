module top_module(
  input [7:0] p1, 
  output p1y, 
  input [7:0] p2, 
  output p2y
  );
  
  wire [3:0] p1nand;
  wire [3:0] p2nand;
  
  assign p1nand[0] = p1[0] & p1[1] & p1[2] & p1[3];
  assign p1nand[1] = p1[4] & p1[5] & p1[6] & p1[7];
  
  assign p2nand[0] = p2[0] & p2[1] & p2[2] & p2[3];
  assign p2nand[1] = p2[4] & p2[5] & p2[6] & p2[7];
  
  assign p1y = p1nand[0] & p1nand[1];
  assign p2y = p2nand[0] & p2nand[1];
  
endmodule
