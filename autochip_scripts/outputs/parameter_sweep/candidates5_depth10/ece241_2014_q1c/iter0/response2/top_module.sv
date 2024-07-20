module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare the internal wire for carry
	wire carry;

	// Declare the internal wire for overflow
	wire overflow_wire;

	// Adder to calculate s
	assign {carry, s} = a + b;

	// Overflow detection logic
	assign overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);

endmodule
