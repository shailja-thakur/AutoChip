module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
  
  // Create internal wires for intermediate calculations
  wire w1, w2;
  
  // Create instance of XOR gate
  xor_gate xor1(.in1(a), .in2(b), .out(w1));
  
  // Create instance of XOR gate
  xor_gate xor2(.in1(w1), .in2(cin), .out(sum));
  
  // Create instance of AND gate
  and_gate and1(.in1(a), .in2(b), .out(w2));
  
  // Create instance of AND gate
  and_gate and2(.in1(w1), .in2(cin), .out(w3));
  
  // Create instance of OR gate
  or_gate or1(.in1(w2), .in2(w3), .out(cout));
  
endmodule
module xor_gate (
  input in1,
  input in2,
  output out
);
  assign out = in1 ^ in2;
endmodule
module and_gate (
  input in1,
  input in2,
  output out
);
  assign out = in1 & in2;
endmodule
module or_gate (
  input in1,
  input in2,
  output out
);
  assign out = in1 | in2;
endmodule
