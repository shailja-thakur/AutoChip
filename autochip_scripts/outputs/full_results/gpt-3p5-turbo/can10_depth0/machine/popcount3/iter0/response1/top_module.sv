module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Declare internal wire for intermediate signals
	wire [2:0] sum;

	// Assign the output bits by adding the input bits together
	assign sum = in[2] + in[1] + in[0];
	assign out[1] = sum[2];
	assign out[0] = sum[1];

endmodule
