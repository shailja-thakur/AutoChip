module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
  
  // Declare internal signals
  wire s1, s2, s3;
  
  // Instantiate the XOR gates
  xor_gate G1(.a(a), .b(b), .out(s1));
  xor_gate G2(.a(s1), .b(cin), .out(sum));
  
  // Instantiate the AND gates
  and_gate G3(.a(a), .b(b), .out(s2));
  and_gate G4(.a(a), .b(cin), .out(s3));
  and_gate G5(.a(b), .b(cin), .out(cout));
  
  // Instantiate the OR gates
  or_gate G6(.a(s2), .b(s3), .out(cout));
  
endmodule
module xor_gate (
  input a,
  input b,
  output out
);
  assign out = a ^ b;
endmodule
module and_gate (
  input a,
  input b,
  output out
);
  assign out = a & b;
endmodule
module or_gate (
  input a,
  input b,
  output out
);
  assign out = a | b;
endmodule
