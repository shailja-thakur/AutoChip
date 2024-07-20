module top_module(
  input [1:0] A,
  input [1:0] B,
  output z);

  // Creating a 2-input XOR gate for each pair of corresponding bits in A and B
  wire [1:0] xor_out;
  assign xor_out = A ^ B;

  // Performing a bitwise AND operation on the output of XOR gates
  assign z = xor_out[1] & xor_out[0];

endmodule
