module top_module(
  input x,
  input y,
  output z
);
  
  // Declare intermediate wire
  wire w1;
  
  // Implement logical XOR
  assign w1 = x ^ y;
  
  // Implement logical AND
  assign z = w1 & x;
  
endmodule
