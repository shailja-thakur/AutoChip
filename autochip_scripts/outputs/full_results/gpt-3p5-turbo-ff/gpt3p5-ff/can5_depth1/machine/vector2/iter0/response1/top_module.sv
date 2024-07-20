module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Declare internal wire variables
	wire [7:0] chunk0, chunk1, chunk2, chunk3;

	// Split the input into 8-bit chunks
	assign chunk0 = in[7:0];
	assign chunk1 = in[15:8];
	assign chunk2 = in[23:16];
	assign chunk3 = in[31:24];

	// Rearrange the input chunks to form the output
	assign out = {chunk3, chunk2, chunk1, chunk0};

endmodule
