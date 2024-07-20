module top_module(
  input x,
  input y,
  output z);

  wire xor_result;
  wire neg_result;
  
  xor_gate xor1(x, y, xor_result);
  negation_gate neg1(xor_result, neg_result);
  
  assign z = neg_result;

endmodule
module xor_gate(
  input a,
  input b,
  output c);
  
  assign c = a ^ b;
  
endmodule
module negation_gate(
  input a,
  output b);
  
  assign b = ~a;
  
endmodule
