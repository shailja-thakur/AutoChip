module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] sum_bits;

full_adder adder0(.a(x[0]), .b(y[0]), .c_in(0), .sum(sum_bits[0]), .c_out(carry[0]));
full_adder adder1(.a(x[1]), .b(y[1]), .c_in(carry[0]), .sum(sum_bits[1]), .c_out(carry[1]));
full_adder adder2(.a(x[2]), .b(y[2]), .c_in(carry[1]), .sum(sum_bits[2]), .c_out(carry[2]));
full_adder adder3(.a(x[3]), .b(y[3]), .c_in(carry[2]), .sum(sum_bits[3]), .c_out(carry[3]));

assign sum = {carry[3], sum_bits};

endmodule
