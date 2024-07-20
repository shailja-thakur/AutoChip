module top_module(
  input [1:0] A,
  input [1:0] B,
  output z);
  
  // Declare intermediate variables
  wire[1:0] xor_result;

  // Bit-by-bit xor operation
  assign xor_result[0] = A[0] ^ B[0];
  assign xor_result[1] = A[1] ^ B[1];

  // Output z is 1 if all xor_result bits are 0
  assign z = ~(xor_result[0] | xor_result[1]);
  
endmodule
