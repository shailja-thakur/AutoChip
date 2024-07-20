module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Internal signals
	wire [3:0] carry_out;
	
	// Instantiate the full adders
	full_adder fa0 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .cout(carry_out[0]));
	full_adder fa1 (.a(x[1]), .b(y[1]), .cin(carry_out[0]), .sum(sum[1]), .cout(carry_out[1]));
	full_adder fa2 (.a(x[2]), .b(y[2]), .cin(carry_out[1]), .sum(sum[2]), .cout(carry_out[2]));
	full_adder fa3 (.a(x[3]), .b(y[3]), .cin(carry_out[2]), .sum(sum[3]), .cout(carry_out[3]));
	
	// Assign overflow bit to the fifth bit of the sum
	assign sum[4] = carry_out[3];
	
endmodule
