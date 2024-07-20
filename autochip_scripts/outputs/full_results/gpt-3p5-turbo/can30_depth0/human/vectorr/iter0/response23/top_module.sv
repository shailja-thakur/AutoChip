module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Define internal wires
	wire [7:0] reverse;

	// Reverse the bit ordering
	assign reverse[7] = in[0];
	assign reverse[6] = in[1];
	assign reverse[5] = in[2];
	assign reverse[4] = in[3];
	assign reverse[3] = in[4];
	assign reverse[2] = in[5];
	assign reverse[1] = in[6];
	assign reverse[0] = in[7];

	// Assign the reversed bits to the output
	assign out = reverse;

endmodule
