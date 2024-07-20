module top_module(
  input p1a, 
  input p1b, 
  input p1c, 
  input p1d, 
  output p1y, 
  input p2a, 
  input p2b, 
  input p2c, 
  input p2d, 
  output p2y
);

wire nand1_out;
wire nand2_out;

nand4 nand1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(nand1_out));
nand4 nand2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(nand2_out));
nand2 nand3(.a(nand1_out), .b(nand2_out), .y(p1y));
nand2 nand4(.a(nand1_out), .b(nand2_out), .y(p2y));

endmodule
