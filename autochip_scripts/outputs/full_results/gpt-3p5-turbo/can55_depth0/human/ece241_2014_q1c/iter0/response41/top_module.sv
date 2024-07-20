module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire to store the sum of a and b
	wire [7:0] sum;
	// Wire to store the overflow value
	wire overflow;

	// Assign sum and overflow using full-adder
	assign {overflow,sum} = a + b;

	// Output assignments
	assign s = sum;
	assign overflow = overflow;

endmodule
