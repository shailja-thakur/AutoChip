module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry; // declare the carry bit for each full adder

// instantiate 4 full adders
full_adder fa0 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .cout(carry[0]));
full_adder fa1 (.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
full_adder fa2 (.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
full_adder fa3 (.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));

// assign the final carry bit
assign sum[4] = carry[3];

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

wire s1, s2, s3;

// create intermediate wires for the XOR and AND gates
assign s1 = a ^ b;
assign sum = s1 ^ cin;
assign s2 = a & b;
assign s3 = s1 & cin;
assign cout = s2 | s3;

endmodule
