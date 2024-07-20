module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Create a temporary wire to store the reversed bits
	wire [7:0] temp;

	// Reverse the bit order
	assign temp[7] = in[0];
	assign temp[6] = in[1];
	assign temp[5] = in[2];
	assign temp[4] = in[3];
	assign temp[3] = in[4];
	assign temp[2] = in[5];
	assign temp[1] = in[6];
	assign temp[0] = in[7];

	// Assign the reversed bits to the output
	assign out = temp;

endmodule
