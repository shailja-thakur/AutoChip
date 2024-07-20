module top_module(
	input [7:0] p1,
	output p1y,
	input [7:0] p2,
	output p2y
);
  wire [7:0] nand1_out;
  wire [7:0] nand2_out;

  assign nand1_out = ~(p1 & p2);
  assign nand2_out = ~(p1 & p2);
  
  assign p1y = nand1_out[0] & nand1_out[1] & nand1_out[2] & nand1_out[3];
  assign p2y = nand2_out[0] & nand2_out[1] & nand2_out[2] & nand2_out[3];
endmodule
