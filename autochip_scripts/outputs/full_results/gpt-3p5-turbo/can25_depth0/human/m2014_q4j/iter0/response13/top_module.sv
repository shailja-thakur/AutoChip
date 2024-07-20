module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Internal wire declaration
	wire [3:0] c_out;
	
	// Full adder instantiation
	full_adder FA0 (.a(x[0]), .b(y[0]), .c_in(0), .sum(sum[0]), .c_out(c_out[0]));
	full_adder FA1 (.a(x[1]), .b(y[1]), .c_in(c_out[0]), .sum(sum[1]), .c_out(c_out[1]));
	full_adder FA2 (.a(x[2]), .b(y[2]), .c_in(c_out[1]), .sum(sum[2]), .c_out(c_out[2]));
	full_adder FA3 (.a(x[3]), .b(y[3]), .c_in(c_out[2]), .sum(sum[3]), .c_out(c_out[3]));
	
	// Output overflow bit
	assign sum[4] = c_out[3];
	
endmodule
module full_adder (
	input a,
	input b,
	input c_in,
	output sum,
	output c_out
);
	
	assign sum = (a ^ b) ^ c_in;
	assign c_out = (a & b) | (c_in & (a ^ b));
	
endmodule
