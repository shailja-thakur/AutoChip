module top_module(
  input x,
  input y,
  output z
);
  // Declare intermediate signals
  wire xor_output;
  
  // Perform XOR operation
  assign xor_output = x ^ y;
  
  // Perform logical AND operation
  assign z = x & xor_output;
endmodule
