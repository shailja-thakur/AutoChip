module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Assuming we also need a carry bit output
	output carry;

	// Assigning the output
	assign {carry, sum} = x + y;

endmodule
