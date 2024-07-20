module top_module (
  input in1,
  input in2,
  input in3,
  output logic out
);

  // Intermediate wire to hold the result of bitwise XOR operation
  wire xor_result;
  
  // Perform bitwise XOR operation on in1 and in2
  assign xor_result = in1 ^ in2;
  
  // Perform bitwise NOT operation on xor_result
  assign out = ~xor_result;
  
  // Perform bitwise XOR operation on not_result and in3
  assign out = out ^ in3;
  
endmodule
