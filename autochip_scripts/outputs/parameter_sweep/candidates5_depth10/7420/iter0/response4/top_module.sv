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
  
  // Internal signals
  wire p1n1, p1n2, p2n1, p2n2;
  
  // NAND Gates
  nandgate n1(p1a, p1b, p1c, p1d, p1n1);
  nandgate n2(p2a, p2b, p2c, p2d, p2n1);
  
  nandgate n3(p1n1, p1n1, p1n1, p1n1, p1y);
  nandgate n4(p2n1, p2n1, p2n1, p2n1, p2y);
  
endmodule
module nandgate(
  input a,
  input b,
  input c,
  input d,
  output y
);
  assign y = ~(a & b & c & d);
endmodule
