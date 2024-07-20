module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  assign {sum[3:0], sum[4]} = x + y;

endmodule
