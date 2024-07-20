module top_module(
  input wire x,
  input wire y,
  output wire z
);
  
  wire a, b;
  
  // First Gate
  and gate1(a, x, y);
  
  // Second Gate
  or gate2(b, x, y);
  
  // Third Gate
  or gate3(z, a, b);
  
endmodule
