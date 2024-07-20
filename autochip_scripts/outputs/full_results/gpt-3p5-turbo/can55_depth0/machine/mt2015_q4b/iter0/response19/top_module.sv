module top_module(
  input x,
  input y,
  output z);

  // Intermediate wires
  wire xor_result;
  wire or_result;
  wire and_result;

  // XOR gate
  xor xor1(x, y, xor_result);

  // OR gate
  or or1(x, y, or_result);

  // AND gate
  and and1(x, y, and_result);

  // Negation and final output
  not not1(xor_result, z);

endmodule
