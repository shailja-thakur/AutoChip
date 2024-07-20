module top_module(
  input [1:0] A,
  input [1:0] B,
  output z);

  // Internal signal to hold the result of the comparison
  wire [1:0] equal_bits;

  // XOR each bit of A and B to determine equality
  assign equal_bits = A ^ B;

  // The output z is set to 1 if all bits of equal_bits are 0, otherwise set to 0
  assign z = (equal_bits[1] | equal_bits[0]) ? 0 : 1;

endmodule
