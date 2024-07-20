module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Internal signal declaration
	wire [4:0] sum_int;

	// Adder logic
	assign sum_int = x + y;

	// Assign sum output
	assign sum = sum_int;

endmodule
