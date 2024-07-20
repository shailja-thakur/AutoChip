module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Internal wires for overflow detection
	wire signed [8:0] sum;
	wire signed [8:0] sum_extended;

	// Carry out from bit 7 and carry in for overflow detection
	wire carry_out;
	wire carry_in;

	// Overflow detection
	assign carry_in = sum[8] ^ sum_extended[8];
	assign overflow = carry_out ^ carry_in;

	// Adder
	assign {carry_out, s} = a + b;

	// Sign-extend for overflow detection
	assign sum_extended[8:0] = {{8{carry_out}}, s};
	assign sum[8:0] = {{8{a[7]}}, a} + {{8{b[7]}}, b};

endmodule
