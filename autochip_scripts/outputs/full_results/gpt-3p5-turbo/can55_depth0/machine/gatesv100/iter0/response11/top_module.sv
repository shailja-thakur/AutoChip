module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Intermediate signals
	wire [98:0] in_shifted; // Shifted input signal for out_different

	// Generate out_both signal
	assign out_both = in & in_shifted;

	// Generate out_any signal
	assign out_any = in | in_shifted;

	// Generate out_different signal
	assign out_different = {in[0] ^ in_shifted[99], in ^ in_shifted};

	// Generate in_shifted by shifting in to the right
	assign in_shifted = {in[98:0], 1'b0};

endmodule
