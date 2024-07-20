module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] sum_temp;

full_adder fa0(x[0], y[0], 1'b0, sum_temp[0], carry[0]);
full_adder fa1(x[1], y[1], carry[0], sum_temp[1], carry[1]);
full_adder fa2(x[2], y[2], carry[1], sum_temp[2], carry[2]);
full_adder fa3(x[3], y[3], carry[2], sum_temp[3], carry[3]);

assign sum = {carry[3], sum_temp};

endmodule
