module top_module (
    input a, 
    input b, 
    output q
);
  
  assign q = a & b;
  // assign q = a && b;   Can also be implemented using '&&' operator instead of '&' operator
endmodule
