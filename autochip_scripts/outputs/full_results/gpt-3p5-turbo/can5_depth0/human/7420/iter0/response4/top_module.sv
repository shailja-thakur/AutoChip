module top_module(
	input [7:0] p1,
	output p1y,
	input [7:0] p2,
	output p2y
);
  wire [3:0] nand1_input;
  wire [3:0] nand2_input;

  assign nand1_input = {p1[1], p1[2], p1[3], p1[4]};
  assign nand2_input = {p1[5], p1[6], p1[7], p1[0]};

  nand4x1 nand1(
    .a(nand1_input[0]),
    .b(nand1_input[1]),
    .c(nand1_input[2]),
    .d(nand1_input[3]),
    .y(p1y)
  );

  nand4x1 nand2(
    .a(nand2_input[0]),
    .b(nand2_input[1]),
    .c(nand2_input[2]),
    .d(nand2_input[3]),
    .y(p2y)
  );

endmodule
