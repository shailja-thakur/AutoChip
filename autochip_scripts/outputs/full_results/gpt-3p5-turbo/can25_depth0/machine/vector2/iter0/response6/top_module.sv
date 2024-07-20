module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Define internal wires to store rearranged bits
	wire [7:0] chunk_1, chunk_2, chunk_3, chunk_4;

	// Assign each chunk of input bits to corresponding chunks of output
	assign chunk_1 = in[7:0];
	assign chunk_2 = in[15:8];
	assign chunk_3 = in[23:16];
	assign chunk_4 = in[31:24];

	// Concatenate the rearranged chunks to form the output
	assign out = {chunk_4, chunk_3, chunk_2, chunk_1};

endmodule
