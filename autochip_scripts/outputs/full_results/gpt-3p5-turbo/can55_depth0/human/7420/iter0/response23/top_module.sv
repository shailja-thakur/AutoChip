module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire [3:0] nand1_out;
  wire [3:0] nand2_out;

  // First NAND gate
  nand nand1(p1[0], p1[1], p1[2], p1[3], nand1_out[0]);
  nand nand2(p1[4], p1[5], p1[6], p1[7], nand1_out[1]);

  // Second NAND gate
  nand nand3(p2[0], p2[1], p2[2], p2[3], nand2_out[0]);
  nand nand4(p2[4], p2[5], p2[6], p2[7], nand2_out[1]);

  // Output assignment
  assign p1y = nand1_out[0] & nand1_out[1];
  assign p2y = nand2_out[0] & nand2_out[1];

endmodule
module nand(input a, input b, input c, input d, output y);
  assign y = ~(a & b & c & d);
endmodule
