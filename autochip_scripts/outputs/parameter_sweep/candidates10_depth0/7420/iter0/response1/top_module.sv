module top_module(
  input [7:0] p1, 
  output p1y, 
  input [7:0] p2, 
  output p2y
);

  wire nand1_out;
  wire nand2_out;

  nand4 nand1(p1[0], p1[1], p1[2], p1[3], nand1_out);
  nand4 nand2(p2[0], p2[1], p2[2], p2[3], nand2_out);

  nand2 nand3(nand1_out, nand2_out, p1y);
  nand2 nand4(nand1_out, nand2_out, p2y);

endmodule
module nand2(input a, input b, output y);
  assign y = ~(a & b);
endmodule
module nand4(input a, input b, input c, input d, output y);
  wire w1, w2;

  nand2 n1(a, b, w1);
  nand2 n2(c, d, w2);
  nand2 n3(w1, w2, y);

endmodule
