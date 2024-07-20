module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);
	
	wire [99:0] shifted_in;

	// Generate the second input signal by shifting the first input signal to the right by 1 bit.
	assign shifted_in = {1'b0, in[99:1]};

    // Generate the out_both signal by performing a bit-wise AND operation between the input signals.
	assign out_both = in[99:1] & shifted_in[98:0];

	// Generate the out_any signal by performing a bit-wise OR operation between the input signals.
	assign out_any = in | shifted_in;

	// Generate the out_different signal by performing a bit-wise XOR operation between the input signals.
	assign out_different = in ^ shifted_in;

endmodule
