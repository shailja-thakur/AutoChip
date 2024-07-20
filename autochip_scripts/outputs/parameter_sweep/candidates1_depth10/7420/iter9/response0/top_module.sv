module top_module (
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

  nand4 nand1 (
    .a(p1a), 
    .b(p1b), 
    .c(p1c), 
    .d(p1d), 
    .y(nand1_out)
  );

  nand4 nand2 (
    .a(p2a), 
    .b(p2b), 
    .c(p2c), 
    .d(p2d), 
    .y(nand2_out)
  );

  assign p1y = ~nand1_out;
  assign p2y = ~nand2_out;
endmodule
module nand4 (
  input a, 
  input b, 
  input c, 
  input d, 
  output y
);
  wire nand1_out;
  wire nand2_out;
  wire nand3_out;

  nand2 nand_instance1 (
    .a(a), 
    .b(b), 
    .y(nand1_out)
  );

  nand2 nand_instance2 (
    .a(c), 
    .b(d), 
    .y(nand2_out)
  );

  nand2 nand_instance3 (
    .a(nand1_out),
    .b(nand2_out),
    .y(nand3_out)
  );

  nand2 nand_instance4 (
    .a(nand3_out),
    .b(nand3_out),
    .y(y)
  );
endmodule
module nand2 (
  input a, 
  input b, 
  output y
);
  wire nand_out;

  nand nand_instance (
    .a(a), 
    .b(b), 
    .y(nand_out)
  );

  assign y = ~nand_out;
endmodule
module nand (
  input a, 
  input b, 
  output y
);
  assign y = ~(a & b);
endmodule
