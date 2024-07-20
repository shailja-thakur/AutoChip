module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Declare internal signals
	wire carry_out;
	wire [3:0] sum_bits;
	
	// Instantiate full adders
	full_adder fa0 (.a(x[0]), .b(y[0]), .carry_in(0), .sum(sum_bits[0]), .carry_out(carry_out[0]));
	full_adder fa1 (.a(x[1]), .b(y[1]), .carry_in(carry_out[0]), .sum(sum_bits[1]), .carry_out(carry_out[1]));
	full_adder fa2 (.a(x[2]), .b(y[2]), .carry_in(carry_out[1]), .sum(sum_bits[2]), .carry_out(carry_out[2]));
	full_adder fa3 (.a(x[3]), .b(y[3]), .carry_in(carry_out[2]), .sum(sum_bits[3]), .carry_out(carry_out[3]));
	
	// Connect internal signals to output
	assign sum[4] = carry_out[3];
	assign sum[3:0] = sum_bits;
	
endmodule
module full_adder (
	input a,
	input b,
	input carry_in,
	output sum,
	output carry_out
);
	
	// Implement the logic for a full adder
	assign sum = a ^ b ^ carry_in;
	assign carry_out = (a & b) | (carry_in & (a ^ b));
	
endmodule
