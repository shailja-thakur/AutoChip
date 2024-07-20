module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Declare internal wires
	wire [2:0] sum;

	// Declare internal signals
	assign sum = in + 3'b001;

	// Assign outputs
	assign out = sum[1:0];

endmodule
