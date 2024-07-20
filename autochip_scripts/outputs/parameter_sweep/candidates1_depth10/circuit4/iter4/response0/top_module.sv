module top_module (
  input a, 
  input b, 
  input c, 
  input d,
  output q
);
 
  // Define intermediate signals
  wire ab;
  wire ab_c;
  wire ab_c_d;
 
  // Generate intermediate signals
  assign ab = a & b;
  assign ab_c = ab | c;
  assign ab_c_d = ab_c & ~d;
 
  // Assign output
  assign q = ~ab_c_d;
 
endmodule
