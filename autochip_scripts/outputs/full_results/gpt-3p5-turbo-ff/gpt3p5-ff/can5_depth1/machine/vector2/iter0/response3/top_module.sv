module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Create temporary signals to store the rearranged bits
	wire [7:0] chunk1;
	wire [7:0] chunk2;
	wire [7:0] chunk3;
	wire [7:0] chunk4;

	// Assign the first 8 bits of the input to the first 8 bits of chunk1
	assign chunk1 = in[7:0];

	// Assign the next 8 bits of the input to the first 8 bits of chunk2
	assign chunk2 = in[15:8];

	// Assign the next 8 bits of the input to the first 8 bits of chunk3
	assign chunk3 = in[23:16];

	// Assign the last 8 bits of the input to the first 8 bits of chunk4
	assign chunk4 = in[31:24];

	// Combine the rearranged chunks to form the output
	assign out = {chunk4, chunk3, chunk2, chunk1};

endmodule
