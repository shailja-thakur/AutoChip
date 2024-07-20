module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// internal wires
	wire [3:0] carry;
	wire [3:0] carry_out;

	// full adders
	full_adder FA0(.x(x[0]), .y(y[0]), .cin(1'b0), .sum(sum[0]), .cout(carry[0]));
	full_adder FA1(.x(x[1]), .y(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
	full_adder FA2(.x(x[2]), .y(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
	full_adder FA3(.x(x[3]), .y(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));

	// overflow bit
	assign sum[4] = carry_out[3];

	// carry propagation
	assign carry_out[0] = carry[0];
	assign carry_out[1] = carry[1];
	assign carry_out[2] = carry[2];
	assign carry_out[3] = carry[3];
	
endmodule
module full_adder (x, y, cin, sum, cout);
	input x, y, cin;
	output sum, cout;

	assign sum = x ^ y ^ cin;
	assign cout = (x & y) | (x & cin) | (y & cin);
	
endmodule
