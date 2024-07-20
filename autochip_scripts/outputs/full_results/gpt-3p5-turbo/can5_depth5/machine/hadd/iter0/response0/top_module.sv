module top_module (
  input [N-1:0] a,
  input [N-1:0] b,
  output [N:0] sum,
  output cout
);
  
  assign {cout, sum} = a + b;

endmodule
