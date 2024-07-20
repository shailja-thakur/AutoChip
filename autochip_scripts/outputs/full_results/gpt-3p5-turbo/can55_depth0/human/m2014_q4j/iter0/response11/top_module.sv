module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] s;

full_adder fa0 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(s[0]), .cout(carry[0]));
full_adder fa1 (.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(s[1]), .cout(carry[1]));
full_adder fa2 (.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(s[2]), .cout(carry[2]));
full_adder fa3 (.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(s[3]), .cout(carry[3]));

assign sum[0] = s[0];
assign sum[1] = s[1];
assign sum[2] = s[2];
assign sum[3] = s[3];
assign sum[4] = carry[3];

endmodule
