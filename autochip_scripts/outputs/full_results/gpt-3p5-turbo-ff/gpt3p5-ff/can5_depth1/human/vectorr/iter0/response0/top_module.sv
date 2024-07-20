module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Create temporary wires to store the reversed bits
	wire [7:0] reversed_bits;

	// Reverse the bit ordering
	assign reversed_bits[0] = in[7];
	assign reversed_bits[1] = in[6];
	assign reversed_bits[2] = in[5];
	assign reversed_bits[3] = in[4];
	assign reversed_bits[4] = in[3];
	assign reversed_bits[5] = in[2];
	assign reversed_bits[6] = in[1];
	assign reversed_bits[7] = in[0];

	// Output the reversed bits
	assign out = reversed_bits;

endmodule
