module top_module(
  input x,
  input y,
  output z);
  
  wire a, b;
  
  // First Gate
  and gate1(a, x, y);
  
  // Second Gate
  and gate2(b, y, x);
  
  // Third Gate
  or gate3(z, a, b);
  
endmodule
