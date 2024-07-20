module top_module(
  input [7:0] p1,
  input [7:0] p2,
  output p1y,
  output p2y
);

  wire [3:0] nand1_out;
  wire [3:0] nand2_out;

  // First 4-input NAND gate
  nand4 #(4) nand1 (
    .a(p1[3:0]),
    .y(nand1_out)
  );

  // Second 4-input NAND gate
  nand4 #(4) nand2 (
    .a(p2[3:0]),
    .y(nand2_out)
  );

  // Output assignment
  assign p1y = nand1_out[3];
  assign p2y = nand2_out[3];
endmodule
