module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);

  // Full Adder implementation
  wire s1, c1, c2;

  // First Half Adder
  xor (s1, a, b);
  and (c1, a, b);
  
  // Second Half Adder
  xor (sum, s1, cin);
  and (c2, s1, cin);

  // Output Carry
  or (cout, c1, c2);

endmodule
