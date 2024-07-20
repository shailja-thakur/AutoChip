module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Declare internal wire for carry bit
	wire carry;

	// Adder logic
	assign {carry, sum} = x + y;

endmodule
