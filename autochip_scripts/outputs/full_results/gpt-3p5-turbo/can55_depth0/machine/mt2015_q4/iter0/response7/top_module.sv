module top_module(
  input wire x,
  input wire y,
  output reg z);

  wire a1, b1, a2, b2;
  
  // First gate
  and gate1(a1, x, y);
  
  // Second gate
  or gate2(b1, x, y);
  
  // Third gate
  or gate3(z, a1, b1);

endmodule
