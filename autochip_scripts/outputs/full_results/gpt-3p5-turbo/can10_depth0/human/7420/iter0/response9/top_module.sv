module top_module (
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire nand1out;
  wire nand2out;

  nand nand1 (nand1out, p1[0], p1[1], p1[2], p1[3]); // First 4-input NAND gate
  nand nand2 (nand2out, p1[4], p1[5], p1[6], p1[7]); // Second 4-input NAND gate

  assign p1y = nand1out;
  assign p2y = nand2out;

endmodule
module nand (output o, input a, input b, input c, input d);
  assign o = ~(a & b & c & d);
endmodule
