module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Create wire to handle intermediate signals
  wire w1, w2, w3;
  
  // Create XOR gates
  xor_gate xor1(.a(a), .b(b), .o(w1));
  xor_gate xor2(.a(w1), .b(cin), .o(sum));
  
  // Create AND gates
  and_gate and1(.a(a), .b(b), .o(w2));
  and_gate and2(.a(b), .b(cin), .o(w3));
  and_gate and3(.a(cin), .b(a), .o(w3));
  
  // Create OR gate
  or_gate or1(.a(w2), .b(w3), .o(cout));
  
endmodule
