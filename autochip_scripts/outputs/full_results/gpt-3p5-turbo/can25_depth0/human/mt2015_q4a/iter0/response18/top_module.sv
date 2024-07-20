module top_module(
  input x,
  input y,
  output z);

  // Wire to store the result of x^y
  wire xor_result;

  // Perform XOR operation between x and y
  assign xor_result = x ^ y;

  // Perform AND operation between xor_result and x
  assign z = xor_result & x;

endmodule
