module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// 4-bit ripple carry adders
	wire [3:0] s;
	wire carry_out;

	full_adder fa0(.a(x[0]), .b(y[0]), .c_in(1'b0), .sum(s[0]), .carry_out(carry_out0));
	full_adder fa1(.a(x[1]), .b(y[1]), .c_in(carry_out0), .sum(s[1]), .carry_out(carry_out1));
	full_adder fa2(.a(x[2]), .b(y[2]), .c_in(carry_out1), .sum(s[2]), .carry_out(carry_out2));
	full_adder fa3(.a(x[3]), .b(y[3]), .c_in(carry_out2), .sum(s[3]), .carry_out(carry_out));

	// assigning the overflow bit to the MSB of the sum
	assign sum[4] = carry_out;

	// concatenating the sum and carry_out signals to get the final output
	assign sum[3:0] = s;
endmodule
