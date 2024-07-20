module top_module(
  input x,
  input y,
  output z);

  // Implementing logic gate
  wire xor_output;
  
  xor_gate xor1(.a(x), .b(y), .z(xor_output));
  not_gate not1(.a(xor_output), .z(z));

endmodule
module xor_gate(
  input a,
  input b,
  output z);
  
  assign z = a ^ b;
  
endmodule
module not_gate(
  input a,
  output z);
  
  assign z = ~a;
  
endmodule
