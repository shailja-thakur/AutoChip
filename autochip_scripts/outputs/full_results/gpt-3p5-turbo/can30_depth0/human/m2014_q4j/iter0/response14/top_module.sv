module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;

// Instantiate full adders
full_adder fa0(.a(x[0]), .b(y[0]), .cin(0), .sum(sum[0]), .carry(carry[0]));
full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .carry(carry[1]));
full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .carry(carry[2]));
full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .carry(carry[3]));

// Output overflow bit
assign sum[4] = carry[3];

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output carry
);

wire w1, w2, w3;

// Implement XOR gates
assign w1 = a ^ b;
assign sum = w1 ^ cin;

// Implement AND gates
assign w2 = a & b;
assign w3 = w1 & cin;
assign carry = w2 | w3;

endmodule
