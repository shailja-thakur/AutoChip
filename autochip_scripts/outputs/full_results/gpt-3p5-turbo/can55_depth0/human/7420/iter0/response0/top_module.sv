module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire [3:0] and1_output;
  wire [3:0] and2_output;
  wire [3:0] nand_output;

  assign and1_output = p1 & p2;
  assign and2_output = p1 & p2;
  assign nand_output = ~(and1_output | and2_output);

  assign p1y = nand_output[0];
  assign p2y = nand_output[1];

endmodule
