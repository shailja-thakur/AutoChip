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
  
  wire nand1;
  wire nand2;
  
  nand_gate u1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(nand1));
  nand_gate u2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(nand2));
  
  assign p1y = nand1;
  assign p2y = nand2;
  
  // NAND gate implementation
  module nand_gate(
    input a,
    input b,
    input c,
    input d,
    output y
  );
  
    assign y = ~(a & b & c & d);
    
  endmodule
