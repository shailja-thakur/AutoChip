module top_module (
  input a,
  input b,
  output out_and,
  output out_or,
  output out_xor,
  output out_nand,
  output out_nor,
  output out_xnor,
  output out_anotb
);

  // perform logical AND operation between inputs a and b
  assign out_and = a & b;

  // perform logical OR operation between inputs a and b
  assign out_or = a | b;

  // perform logical XOR operation between inputs a and b
  assign out_xor = a ^ b;

  // perform logical NAND operation between inputs a and b
  assign out_nand = ~(a & b);

  // perform logical NOR operation between inputs a and b
  assign out_nor = ~(a | b);
  
  // perform logical XNOR operation between inputs a and b
  assign out_xnor = ~(a ^ b);
  
  // perform logical AND NOT operation between inputs a and b
  assign out_anotb = a & ~b;

endmodule
