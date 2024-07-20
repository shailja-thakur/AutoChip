module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Internal signals
	wire [7:0] chunk1, chunk2, chunk3, chunk4;

	// Splitting input into chunks
	assign chunk1 = in[31:24];
	assign chunk2 = in[23:16];
	assign chunk3 = in[15:8];
	assign chunk4 = in[7:0];

	// Rearranging the order of chunks
	assign out = {chunk4, chunk3, chunk2, chunk1};

endmodule
