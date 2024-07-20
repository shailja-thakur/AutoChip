module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
  
  // Internal wires
  wire s1, s2, c1, c2;
  
  // First stage of the full adder
  xor_gate x1 (.a(a), .b(b), .y(s1));
  xor_gate x2 (.a(s1), .b(cin), .y(sum));
  and_gate a1 (.a(s1), .b(cin), .y(c1));
  
  // Second stage of the full adder
  xor_gate x3 (.a(sum), .b(c1), .y(s2));
  and_gate a2 (.a(sum), .b(c1), .y(c2));
  
  // Output drivers
  assign cout = c2;
  
endmodule
module xor_gate (
  input a,
  input b,
  output y
);
  assign y = a^b;
endmodule
module and_gate (
  input a,
  input b,
  output y
);
  assign y = a&b;
endmodule
