module top_module(
  input wire x,
  input wire y,
  output wire z);

  // Intermediate wires
  wire xor_output;
  
  // XOR gate
  xor gate1(.a(x), .b(y), .o(xor_output));
  
  // AND gate
  and gate2(.a(xor_output), .b(x), .z(z));

endmodule
