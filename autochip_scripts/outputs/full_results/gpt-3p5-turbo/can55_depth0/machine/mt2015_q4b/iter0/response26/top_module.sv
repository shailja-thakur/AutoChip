module top_module(
  input x,
  input y,
  output z);
  
  // XOR gate
  wire x_xor_y = x ^ y;
  
  // NOT gate
  wire z = ~x_xor_y;
  
endmodule
