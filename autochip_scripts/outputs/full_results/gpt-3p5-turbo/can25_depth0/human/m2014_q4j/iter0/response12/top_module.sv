module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Uncomment the following line if using the system Verilog syntax
	// assign sum[4] = (x[3] & y[3]) | (x[2] & y[2]) | (x[1] & y[1]) | (x[0] & y[0]);
	
	// Create the full adders
	full_adder FA0 (.a(x[0]), .b(y[0]), .c_in(sum[3]), .sum(sum[0]), .c_out(carry1));
	full_adder FA1 (.a(x[1]), .b(y[1]), .c_in(carry1), .sum(sum[1]), .c_out(carry2));
	full_adder FA2 (.a(x[2]), .b(y[2]), .c_in(carry2), .sum(sum[2]), .c_out(carry3));
	full_adder FA3 (.a(x[3]), .b(y[3]), .c_in(carry3), .sum(sum[3]), .c_out(sum[4]));
	
endmodule
module full_adder (
	input a,
	input b,
	input c_in,
	output sum,
	output c_out
);
	
	assign sum = a ^ b ^ c_in;
	assign c_out = (a & b) | (a & c_in) | (b & c_in);
	
endmodule
