module top_module(
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);

  assign out_or_bitwise = a | b; // bitwise OR of inputs a and b
  
  assign out_or_logical = (a != 3'b0) || (b != 3'b0); // logical OR of inputs a and b
  
  assign out_not = ~{a, b}; // bitwise NOT of inputs a and b, in reverse order

endmodule
