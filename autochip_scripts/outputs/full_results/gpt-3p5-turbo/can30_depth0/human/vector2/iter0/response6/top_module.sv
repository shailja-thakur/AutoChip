module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Creating a temporary vector to store the reversed order
	wire [31:0] temp;

	// Reversing the byte order of the input vector
	assign temp[31:24] = in[7:0];
	assign temp[23:16] = in[15:8];
	assign temp[15:8] = in[23:16];
	assign temp[7:0] = in[31:24];

	// Assigning the reversed vector to the output
	assign out = temp;

endmodule
