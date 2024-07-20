module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
  
  // Create intermediate wires for OR and AND operations
  wire ab_or;
  wire cd_or;
  
  // Implement bitwise OR operations
  assign ab_or = a | b;
  assign cd_or = c | d;
  
  // Implement bitwise AND operation for the final output
  assign q = ab_or & cd_or;
  
endmodule
