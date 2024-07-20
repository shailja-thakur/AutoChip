module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Intermediate wires
	wire [3:0] carry;
	wire [4:0] internal_sum;

	// Instantiate full adders
	full_adder FA0 (.x(x[0]), .y(y[0]), .cin(1'b0), .sum(internal_sum[0]), .cout(carry[0]));
	full_adder FA1 (.x(x[1]), .y(y[1]), .cin(carry[0]), .sum(internal_sum[1]), .cout(carry[1]));
	full_adder FA2 (.x(x[2]), .y(y[2]), .cin(carry[1]), .sum(internal_sum[2]), .cout(carry[2]));
	full_adder FA3 (.x(x[3]), .y(y[3]), .cin(carry[2]), .sum(internal_sum[3]), .cout(carry[3]));

	// Assign output
	assign sum = {carry[3], internal_sum};

endmodule
module full_adder(
	input x,
	input y,
	input cin,
	output sum,
	output cout
);
	// Intermediate wires
	wire s1, s2;

	// Calculate intermediate wires
	xor (s1, x, y);
	xor (sum, s1, cin);
	and (s2, x, y);
	or (cout, s2, and(cin, s1));

endmodule
