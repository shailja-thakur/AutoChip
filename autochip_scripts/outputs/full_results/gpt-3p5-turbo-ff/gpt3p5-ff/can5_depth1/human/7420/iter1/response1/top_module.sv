module top_module(
    input [3:0] p1a, 
    input [3:0] p1b, 
    input [3:0] p1c, 
    input [3:0] p1d, 
    output p1y, 
    input [3:0] p2a, 
    input [3:0] p2b, 
    input [3:0] p2c, 
    input [3:0] p2d, 
    output p2y
);
  // Complete the module implementation here
  wire [3:0] nand_gate1;
  wire [3:0] nand_gate2;

  nand_gate nand1(
    .a(p1a),
    .b(p1b),
    .y(nand_gate1[0])
  );

  nand_gate nand2(
    .a(p1c),
    .b(p1d),
    .y(nand_gate1[1])
  );

  nand_gate nand3(
    .a(p2a),
    .b(p2b),
    .y(nand_gate2[0])
  );

  nand_gate nand4(
    .a(p2c),
    .b(p2d),
    .y(nand_gate2[1])
  );

  nand_gate nand5(
    .a(nand_gate1[0]),
    .b(nand_gate1[1]),
    .y(p1y)
  );

  nand_gate nand6(
    .a(nand_gate2[0]),
    .b(nand_gate2[1]),
    .y(p2y)
  );

endmodule
