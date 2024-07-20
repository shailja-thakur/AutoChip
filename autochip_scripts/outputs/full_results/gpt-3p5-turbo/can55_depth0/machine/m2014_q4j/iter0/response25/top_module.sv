module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Internal wire for the carry bit
	wire carry;

	// Logic for the sum and carry bit
	assign {carry, sum} = x + y;

endmodule
