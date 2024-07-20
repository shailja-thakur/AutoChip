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

  // Logic for out_and
  assign out_and = a & b;
  
  // Logic for out_or
  assign out_or = a | b;
  
  // Logic for out_xor
  assign out_xor = a ^ b;
  
  // Logic for out_nand
  assign out_nand = ~(a & b);
  
  // Logic for out_nor
  assign out_nor = ~(a | b);
  
  // Logic for out_xnor
  assign out_xnor = ~(a ^ b);
  
  // Logic for out_anotb
  assign out_anotb = a & ~b;
  
endmodule
