module top_module (
  input a,
  input b,
  input c,
  input d,
  output q
);
  
  // Logic for q 
  assign q = (~a & ~b & ~c & d) | (c & d);
    
endmodule
