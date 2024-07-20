module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
  
  // Output assignment using logical OR operation
  assign q = b | c;
  
endmodule
