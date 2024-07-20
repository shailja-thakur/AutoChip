module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Add the three input bits together
	wire [1:0] sum;
	assign sum = in[0] + in[1] + in[2];

	// Assign the result to the output
	assign out = sum;

endmodule
