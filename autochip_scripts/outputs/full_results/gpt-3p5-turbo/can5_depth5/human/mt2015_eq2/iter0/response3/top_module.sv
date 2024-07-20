module top_module(
  input [1:0] A,
  input [1:0] B,
  output z);
  
  // Instantiate the XOR gate for each bit of A and B
  wire [1:0] xor_result;
  xor x0(A[0], B[0], xor_result[0]);
  xor x1(A[1], B[1], xor_result[1]);
  
  // Perform an AND operation on the result of the XOR gates
  and gate(z, xor_result[0], xor_result[1]);
  
endmodule
module xor(
  input a,
  input b,
  output out);
  
  assign out = a ^ b;
  
endmodule
