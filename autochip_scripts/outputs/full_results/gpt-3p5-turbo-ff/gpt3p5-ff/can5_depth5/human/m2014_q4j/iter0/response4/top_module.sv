module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

wire [3:0] carry;

assign {carry[3], sum[3:0]} = x + y;

assign carry[2] = x[3] & y[3];
assign carry[1] = (x[2] & y[2]) | (x[3] & y[3]);
assign carry[0] = (x[1] & y[1]) | (x[2] & y[2]) | (x[3] & y[3]);

assign sum[4] = carry[3];

endmodule
