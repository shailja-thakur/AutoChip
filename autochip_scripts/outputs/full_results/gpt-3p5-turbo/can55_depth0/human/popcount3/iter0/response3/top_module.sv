module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Internal wire declaration
	wire [2:0] count;

	// Population count circuit
	assign count = in[0] + in[1] + in[2];
	assign out = count[1:0];

endmodule
