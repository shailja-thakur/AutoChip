module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

wire [3:0] carry;
wire [3:0] s_out;

full_adder a1 (.a(x[0]), .b(y[0]), .cin(0), .sum(s_out[0]), .cout(carry[0]));
full_adder a2 (.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(s_out[1]), .cout(carry[1]));
full_adder a3 (.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(s_out[2]), .cout(carry[2]));
full_adder a4 (.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(s_out[3]), .cout(carry[3]));

assign sum = {carry[3], s_out[3:0]};
endmodule
