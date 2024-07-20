module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Define signals to hold intermediate values
	wire [3:0] xor_out;
	wire [3:0] carry_out;

	// Instantiate 4 full adders
	full_adder fa0 (.a(x[0]), .b(y[0]), .c_in(1'b0), .sum(sum[0]), .carry(carry_out[0]));
	full_adder fa1 (.a(x[1]), .b(y[1]), .c_in(carry_out[0]), .sum(sum[1]), .carry(carry_out[1]));
	full_adder fa2 (.a(x[2]), .b(y[2]), .c_in(carry_out[1]), .sum(sum[2]), .carry(carry_out[2]));
	full_adder fa3 (.a(x[3]), .b(y[3]), .c_in(carry_out[2]), .sum(sum[3]), .carry(carry_out[3]));

	// Assign overflow bit
	assign sum[4] = carry_out[3];

endmodule
module full_adder (
	input a,
	input b,
	input c_in,
	output sum,
	output carry
);
	assign {carry, sum} = a + b + c_in;

endmodule
