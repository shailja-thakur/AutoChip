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

  wire [3:0] nand1;
  wire [3:0] nand2;

  nand4 #(4) u1 (
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .d(p1d),
    .y(nand1)
  );

  nand4 #(4) u2 (
    .a(p2a),
    .b(p2b),
    .c(p2c),
    .d(p2d),
    .y(nand2)
  );

  nand2 #(4) gate (
    .a(nand1),
    .b(nand2),
    .y(p1y)
  );

  nand2 #(4) gate (
    .a(nand1),
    .b(nand2),
    .y(p2y)
  );

endmodule
