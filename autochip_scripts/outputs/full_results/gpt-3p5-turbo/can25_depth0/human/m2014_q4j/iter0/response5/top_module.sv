module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

// Internal wire declaration
wire [3:0] carry;
wire [3:0] sum_temp;

// Instantiate full adders
full_adder adder0(.a(x[0]), .b(y[0]), .cin(1'b0), .s(sum_temp[0]), .cout(carry[0]));
full_adder adder1(.a(x[1]), .b(y[1]), .cin(carry[0]), .s(sum_temp[1]), .cout(carry[1]));
full_adder adder2(.a(x[2]), .b(y[2]), .cin(carry[1]), .s(sum_temp[2]), .cout(carry[2]));
full_adder adder3(.a(x[3]), .b(y[3]), .cin(carry[2]), .s(sum_temp[3]), .cout(carry[3]));

// Assign sum and overflow bit
assign sum = {carry[3], sum_temp};

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output s,
	output cout
);

// Implement XOR gate
assign s = a ^ b;

// Implement AND gates
assign cout = (a & b) | (cin & (a ^ b));

endmodule
