module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Define internal wires
	wire [3:0] x_and_y;
	wire carry_out;

	// Assign internal wires
	assign x_and_y = x + y;
	assign carry_out = x[3] & y[3];

	// Assign sum output
	assign sum = {carry_out, x_and_y};

endmodule
