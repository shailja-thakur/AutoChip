module top_module(
  input x,
  input y,
  output z);

  // Define intermediate signals for clarity
  wire x_xor_y;
  wire x_or_y;
  
  // Compute the XOR of x and y
  assign x_xor_y = x ^ y;
  
  // Compute the OR of x and y
  assign x_or_y = x | y;
  
  // Compute the output z
  assign z = ~(x_or_y & x_xor_y);

endmodule
