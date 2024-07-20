module top_module (
  input a,
  input b,
  output sum,
  output cout
); 

  // Implementation of half adder
  assign sum = a ^ b;
  assign cout = a & b;

endmodule
