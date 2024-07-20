module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Internal wire for the overflow
	wire overflow;

	// Adder for a and b
	assign s = a + b;

	// Detecting the overflow
	assign overflow = (s[7] ^ a[7]) & (s[7] ^ b[7]);

endmodule
