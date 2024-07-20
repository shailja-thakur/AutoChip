module top_module (
  input a,
  input b,
  output sum,
  output cout
);
  
  // Implementing the half adder logic
  assign sum = a ^ b;
  assign cout = a & b;
  
endmodule
