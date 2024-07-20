module top_module (
  input x,
  input y,
  output z
);

  // Instantiate the logic gate
  wire xor_result;
  xor_gate my_xor_gate(x, y, xor_result);
  
  // Perform the logical negation
  assign z = ~xor_result;

endmodule
module xor_gate (
  input a,
  input b,
  output c
);
  
  // Implement the XOR gate using the ^ operator
  assign c = a ^ b;

endmodule
