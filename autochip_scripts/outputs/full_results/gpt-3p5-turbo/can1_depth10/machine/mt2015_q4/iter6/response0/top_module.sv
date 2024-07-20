module top_module(
  input x,
  input y,
  output z);

  wire a;
  wire b;
  
  // First Gate
  assign a = x & ~y;

  // Second Gate
  assign b = x ^ y;

  // Third Gate
  assign z = a | b; // Changed from a & b to a | b
  
endmodule
