module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Define the 4-bit adder components
	wire [3:0] carry;
	wire [3:0] output_sum;

	// Instantiate full adders
	full_adder fa0 (.a(x[0]), .b(y[0]), .ci(1'b0), .sum(output_sum[0]), .co(carry[0]));
	full_adder fa1 (.a(x[1]), .b(y[1]), .ci(carry[0]), .sum(output_sum[1]), .co(carry[1]));
	full_adder fa2 (.a(x[2]), .b(y[2]), .ci(carry[1]), .sum(output_sum[2]), .co(carry[2]));
	full_adder fa3 (.a(x[3]), .b(y[3]), .ci(carry[2]), .sum(output_sum[3]), .co(carry[3]));

	// Connect outputs
	assign sum = {carry[3], output_sum};

endmodule
module full_adder (
	input a,
	input b,
	input ci,
	output sum,
	output co
);
	// Implement the full adder logic
	assign sum = a ^ b ^ ci;
	assign co = (a & b) | (a & ci) | (b & ci);

endmodule
