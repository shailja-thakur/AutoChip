module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wire to store the result of the addition
	wire [8:0] sum;

	// Internal wire to store the overflow status
	wire carry_out;

	// Adder module to perform the addition
	adder adder_inst(
		.a(a),
		.b(b),
		.cin(1'b0),
		.sum(sum),
		.carry_out(carry_out)
	);

	// Output the result of the addition without the carry-out bit
	assign s = sum[7:0];

	// Output the overflow status
	assign overflow = carry_out;

endmodule
