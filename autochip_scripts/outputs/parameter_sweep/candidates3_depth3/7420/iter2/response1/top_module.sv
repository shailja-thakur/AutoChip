module nand4 (input a, input b, input c, input d, output y);
  assign y = ~(a & b & c & d);
endmodule
module nand2 (input [3:0] a, output y);
  assign y = ~(a[0] & a[1] & a[2] & a[3]);
endmodule
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

  nand4 u1 (
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .d(p1d),
    .y(nand1[0])
  );

  nand4 u2 (
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .d(p1d),
    .y(nand1[1])
  );

  nand4 u3 (
    .a(p2a),
    .b(p2b),
    .c(p2c),
    .d(p2d),
    .y(nand2[0])
  );

  nand4 u4 (
    .a(p2a),
    .b(p2b),
    .c(p2c),
    .d(p2d),
    .y(nand2[1])
  );

  nand2 u5 (
    .a(nand1),
    .y(p1y)
  );

  nand2 u6 (
    .a(nand2),
    .y(p2y)
  );

endmodule
