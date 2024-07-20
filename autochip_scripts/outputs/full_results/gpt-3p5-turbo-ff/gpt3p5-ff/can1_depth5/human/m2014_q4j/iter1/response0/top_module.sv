module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] full_adder_sum;
wire overflow;

// Instantiate four full adders
full_adder full_adder0(.a(x[0]), .b(y[0]), .cin(0), .sum(full_adder_sum[0]), .cout(carry[0]));
full_adder full_adder1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(full_adder_sum[1]), .cout(carry[1]));
full_adder full_adder2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(full_adder_sum[2]), .cout(carry[2]));
full_adder full_adder3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(full_adder_sum[3]), .cout(carry[3]));

// Generate overflow signal
assign overflow = carry[3] | (full_adder_sum[3] & carry[2]);

// Concatenate overflow bit and sum outputs
assign sum = {overflow, full_adder_sum};

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

wire s1, s2;

assign s1 = a ^ b;
assign s2 = s1 ^ cin;
assign sum = s2;
assign cout = (a & b) | (s1 & cin);

endmodule
