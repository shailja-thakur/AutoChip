module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

	wire [99:0] shifted_in;

	// Shift the input signal by one bit
	assign shifted_in = {in[98:0], in[99]};

	// Generate the output signals
	assign out_both = in[99:1] & in[98:0]; // Bit-wise AND operation (99-bit wide)
	assign out_any = in | shifted_in;      // Bit-wise OR operation (100-bit wide)
	assign out_different = in ^ shifted_in; // Bit-wise XOR operation (100-bit wide)

endmodule
