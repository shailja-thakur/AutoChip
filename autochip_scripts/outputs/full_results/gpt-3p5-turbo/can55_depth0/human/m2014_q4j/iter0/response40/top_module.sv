module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] c;  // Carry signals between full adders

// Instantiate the four full adders
full_adder fa0(.a(x[0]), .b(y[0]), .cin(0), .sum(sum[0]), .cout(c[0]));
full_adder fa1(.a(x[1]), .b(y[1]), .cin(c[0]), .sum(sum[1]), .cout(c[1]));
full_adder fa2(.a(x[2]), .b(y[2]), .cin(c[1]), .sum(sum[2]), .cout(c[2]));
full_adder fa3(.a(x[3]), .b(y[3]), .cin(c[2]), .sum(sum[3]), .cout(c[3]));

// Assign the overflow bit
assign sum[4] = c[3];

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

assign sum = (a ^ b) ^ cin;
assign cout = (a & b) | (cin & (a ^ b));

endmodule
