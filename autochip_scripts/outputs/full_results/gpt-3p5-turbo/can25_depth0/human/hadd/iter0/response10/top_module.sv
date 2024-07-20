module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// wire declarations
	wire sum_wire, c_out_wire;

	// instantiate the half adder module
	half_adder HA1(.a(a), .b(b), .sum(sum_wire), .carry_out(c_out_wire));

	// assign outputs
	assign sum = sum_wire;
	assign cout = c_out_wire;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output carry_out
);

	// Logic for sum and carry_out
	xor(sum, a, b);
	and(carry_out, a, b);

endmodule
