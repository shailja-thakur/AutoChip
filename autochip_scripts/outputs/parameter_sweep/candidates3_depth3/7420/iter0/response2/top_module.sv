module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire [3:0] nand1;
  wire [3:0] nand2;

  nand4 #(4) u1 (
    .a(p1[0]),
    .b(p1[1]),
    .c(p1[2]),
    .d(p1[3]),
    .y(nand1[0])
  );

  nand4 #(4) u2 (
    .a(p1[4]),
    .b(p1[5]),
    .c(p1[6]),
    .d(p1[7]),
    .y(nand1[1])
  );

  nand4 #(4) u3 (
    .a(p2[0]),
    .b(p2[1]),
    .c(p2[2]),
    .d(p2[3]),
    .y(nand2[0])
  );

  nand4 #(4) u4 (
    .a(p2[4]),
    .b(p2[5]),
    .c(p2[6]),
    .d(p2[7]),
    .y(nand2[1])
  );

  nand2 #(2) u5 (
    .a(nand1),
    .y(p1y)
  );

  nand2 #(2) u6 (
    .a(nand2),
    .y(p2y)
  );

endmodule
