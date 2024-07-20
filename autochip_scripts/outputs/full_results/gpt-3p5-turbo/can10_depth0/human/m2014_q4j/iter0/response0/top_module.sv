module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] sum_3bit;

// Instantiating full adders
full_adder fa0 (.x(x[0]), .y(y[0]), .cin(0), .s(sum_3bit[0]), .cout(carry[0]));
full_adder fa1 (.x(x[1]), .y(y[1]), .cin(carry[0]), .s(sum_3bit[1]), .cout(carry[1]));
full_adder fa2 (.x(x[2]), .y(y[2]), .cin(carry[1]), .s(sum_3bit[2]), .cout(carry[2]));
full_adder fa3 (.x(x[3]), .y(y[3]), .cin(carry[2]), .s(sum_3bit[3]), .cout(carry[3]));

// Overflow bit
assign sum[4] = carry[3];

// Concatenate sum_3bit and carry to form sum
assign sum[3:0] = sum_3bit;
endmodule
module full_adder (
	input x,
	input y,
	input cin,
	output s,
	output cout
);

	assign s = (x ^ y) ^ cin;
	assign cout = (x & y) | (cin & (x ^ y));
endmodule
