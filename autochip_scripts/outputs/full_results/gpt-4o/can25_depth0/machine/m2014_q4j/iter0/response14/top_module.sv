module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Assign the sum of the two 4-bit inputs to the 5-bit output
	assign sum = x + y;

endmodule
