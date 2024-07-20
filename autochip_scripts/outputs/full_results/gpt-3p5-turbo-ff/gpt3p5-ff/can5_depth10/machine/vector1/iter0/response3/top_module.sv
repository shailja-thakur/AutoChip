module top_module (
	input [15:0] in,
	output [7:0] out_hi,
	output [7:0] out_lo
);

	// Declare internal signals
	wire [15:8] upper;
	wire [7:0] lower;

	// Assign input signal to output signals
	assign out_hi = upper;
	assign out_lo = lower;

	// Split input into upper and lower parts
	assign upper = in[15:8];
	assign lower = in[7:0];

endmodule
