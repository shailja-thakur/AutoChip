module top_module(
  input x,
  input y,
  output z
);

  // Internal wire declarations
  wire xor_output;
  
  // XOR gate
  xor_gate xor1(
    .a(x),
    .b(y),
    .c(xor_output)
  );
  
  // AND gate
  and_gate and1(
    .a(xor_output),
    .b(x),
    .c(z)
  );
  
endmodule
module xor_gate(
  input a,
  input b,
  output c
);
  assign c = a ^ b;
endmodule
module and_gate(
  input a,
  input b,
  output c
);
  assign c = a & b;
endmodule
