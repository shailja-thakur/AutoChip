module top_module(
  input wire x,
  input wire y,
  output wire z);

  // Intermediate wires
  wire xor_output;
  
  // XOR gate
  xor gate1(xor_output, x, y);
  
  // AND gate
  and gate2(z, xor_output, x);

endmodule
