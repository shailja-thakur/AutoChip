module top_module (
  input wire a, 
  input wire b, 
  input wire c, 
  input wire d,
  output wire q
);
  
  // Intermediate signals
  wire ab_or;
  wire cd_or;
  
  // Bitwise OR gates
  assign ab_or = a | b;
  assign cd_or = c | d;
  
  // Bitwise AND gate
  assign q = ab_or & cd_or;
  
endmodule
