module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// internal signal for carry bit
	wire carry;

	// generate the sum
	assign sum = {carry, x} + y;

endmodule
