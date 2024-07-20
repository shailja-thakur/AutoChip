module top_module (
  input x,
  input y,
  output z
);

  // wire to store the XOR of the inputs
  wire xor_result;
  
  // logic gates for XOR and AND operations
  assign xor_result = x ^ y;
  assign z = xor_result & x;
  
endmodule
