module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// wire declarations
	wire [3:0] carry;
	wire [3:0] sum_bit;

	// instantiate full adders
	full_adder adder0 (.a(x[0]), .b(y[0]), .c_in(1'b0), .sum(sum_bit[0]), .carry_out(carry[0]));
	full_adder adder1 (.a(x[1]), .b(y[1]), .c_in(carry[0]), .sum(sum_bit[1]), .carry_out(carry[1]));
	full_adder adder2 (.a(x[2]), .b(y[2]), .c_in(carry[1]), .sum(sum_bit[2]), .carry_out(carry[2]));
	full_adder adder3 (.a(x[3]), .b(y[3]), .c_in(carry[2]), .sum(sum_bit[3]), .carry_out(carry[3]));

	// assign sum bits
	assign sum = {carry[3], sum_bit};

endmodule
module full_adder (a, b, c_in, sum, carry_out);
	input a;
	input b;
	input c_in;
	output sum;
	output carry_out;

	wire s1, c1, c2;
	
	// generate sum and carry out
	xor_gate xor1 (.a(a), .b(b), .y(s1));
	xor_gate xor2 (.a(s1), .b(c_in), .y(sum));
	and_gate and1 (.a(a), .b(b), .y(c1));
	and_gate and2 (.a(s1), .b(c_in), .y(c2));
	or_gate or1 (.a(c1), .b(c2), .y(carry_out));

endmodule
module xor_gate (a, b, y);
	input a;
	input b;
	output y;

	assign y = a ^ b;

endmodule
module and_gate (a, b, y);
	input a;
	input b;
	output y;

	assign y = a & b;

endmodule
module or_gate (a, b, y);
	input a;
	input b;
	output y;

	assign y = a | b;

endmodule
