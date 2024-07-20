module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire [7:0] nand1_in;
  wire [7:0] nand2_in;

  assign nand1_in = ~p1;
  assign nand2_in = ~p2;

  assign p1y = ~(nand1_in[0] & nand1_in[1] & nand1_in[2] & nand1_in[3]);
  assign p2y = ~(nand2_in[0] & nand2_in[1] & nand2_in[2] & nand2_in[3]);

endmodule
