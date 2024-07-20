module top_module(
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);
  // bitwise OR of the two vectors
  assign out_or_bitwise = a | b;
  
  // logical OR of the two vectors
  assign out_or_logical = |({a, b});
  
  // inverse (NOT) of b in the upper half of out_not
  assign out_not[5:3] = ~b;
  
  // inverse (NOT) of a in the lower half of out_not
  assign out_not[2:0] = ~a;
endmodule
