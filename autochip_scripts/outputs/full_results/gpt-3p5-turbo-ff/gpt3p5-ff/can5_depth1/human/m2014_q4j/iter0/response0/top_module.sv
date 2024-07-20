module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Declare signals
	wire [3:0] carry;
	wire [3:0] s;

	// Instantiate full adders
	full_adder fa0(.a(x[0]), .b(y[0]), .c_in(0), .sum(s[0]), .c_out(carry[0]));
	full_adder fa1(.a(x[1]), .b(y[1]), .c_in(carry[0]), .sum(s[1]), .c_out(carry[1]));
	full_adder fa2(.a(x[2]), .b(y[2]), .c_in(carry[1]), .sum(s[2]), .c_out(carry[2]));
	full_adder fa3(.a(x[3]), .b(y[3]), .c_in(carry[2]), .sum(s[3]), .c_out(carry[3]));

	// Connect output signals
	assign sum = {carry[3], s};

endmodule
module full_adder (
	input a,
	input b,
	input c_in,
	output sum,
	output c_out
);
	assign sum = a ^ b ^ c_in;
	assign c_out = (a & b) | (b & c_in) | (a & c_in);
endmodule
