module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

	wire [99:0] shifted_in;

	assign shifted_in = {in[98:0], 1'b0}; // Shift 'in' by one bit to the right

	assign out_both = in[99:1] & shifted_in[99:1]; // Bitwise AND resulting in 99-bit wide vector
	assign out_any = in | shifted_in;             // Bitwise OR resulting in 100-bit wide vector

	// Bitwise XOR resulting in 100-bit wide vector, special handling for the first bit
	assign out_different[99:1] = in[99:1] ^ shifted_in[99:1];
	assign out_different[0] = in[0] ^ in[99];

endmodule
