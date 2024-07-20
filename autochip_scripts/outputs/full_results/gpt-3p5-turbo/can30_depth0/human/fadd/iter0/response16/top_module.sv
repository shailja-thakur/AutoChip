module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
  // Implementing a full adder
  wire w1, w2, w3;
  
  // Generate sum bit
  xor(w1, a, b);
  xor(sum, w1, cin);
  
  // Generate carry-out
  and(w2, a, b);
  and(w3, w1, cin);
  or(cout, w2, w3);
  
endmodule
