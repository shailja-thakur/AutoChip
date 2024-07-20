module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Define internal wire for the overflow signal
	wire overflow_wire;

	// Calculate the sum of a and b
	assign s = a + b;

	// Determine if overflow has occurred
	assign overflow_wire = (a[7] && b[7] && !s[7]) || (!a[7] && !b[7] && s[7]);

	// Assign the overflow signal to the output
	assign overflow = overflow_wire;

endmodule
