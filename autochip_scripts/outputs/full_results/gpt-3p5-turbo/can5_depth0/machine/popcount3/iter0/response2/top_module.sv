module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Declare internal signals
	wire [2:0] sum;

	// Adder equations
	assign sum = in[2:0];

	// Assign outputs
	assign out[1] = sum[2];
	assign out[0] = sum[1];

endmodule
