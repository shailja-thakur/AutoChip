module top_module(
    input x,
    input y,
    output z
  );
  
  // Internal wire to compute the XOR operation
  wire xor_output;
  
  // Implementation of XOR gate
  assign xor_output = x ^ y;
  
  // Implementation of AND gate
  assign z = xor_output & x;
  
endmodule
