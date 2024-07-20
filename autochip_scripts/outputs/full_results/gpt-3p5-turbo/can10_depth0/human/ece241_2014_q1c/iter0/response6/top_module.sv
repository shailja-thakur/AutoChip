module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire for carry bit
	wire carry;

	// Wire for checking overflow
	wire overflow_check;

	// Assign carry bit to the overflow check (MSB) of a + b
	assign overflow_check = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);

	// Add a and b using an adder, and assign sum to s
	assign s = a + b;

	// Assign carry out from adder to carry
	assign carry = s[8];

	// Assign overflow output to the overflow bit
	assign overflow = overflow_check | carry;

endmodule
