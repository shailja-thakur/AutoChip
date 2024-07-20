module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  wire [3:0] nand1_out;
  wire [3:0] nand2_out;
  
  nand_gate_4to1 nand1(
    .a(p1[3:0]),
    .y(nand1_out)
  );
  
  nand_gate_4to1 nand2(
    .a(p2[3:0]),
    .y(nand2_out)
  );
  
  nand_gate_2to1 nand3(
    .a(nand1_out),
    .b(nand2_out),
    .y(p1y)
  );
  
  nand_gate_2to1 nand4(
    .a(p1[7:4]),
    .b(p2[7:4]),
    .y(p2y)
  );
  
endmodule
module nand_gate_4to1(
  input [3:0] a,
  output y
);
  assign y = ~(a[0] & a[1] & a[2] & a[3]);
endmodule
module nand_gate_2to1(
  input a,
  input b,
  output y
);
  assign y = ~(a & b);
endmodule
