module top_module(
  input x,
  input y,
  output z );

  // Intermediate wire
  wire xor_output;

  // XOR gate
  xor #(.N(2)) xor_gate(
    .a(x),
    .b(y),
    .out(xor_output)
  );

  // AND gate
  and and_gate(
    .a(xor_output),
    .b(x),
    .z(z)
  );
  
endmodule
