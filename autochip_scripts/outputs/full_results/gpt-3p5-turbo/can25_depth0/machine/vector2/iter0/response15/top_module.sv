module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Declare internal wire connections
	wire [7:0] chunk1;
	wire [7:0] chunk2;
	wire [7:0] chunk3;
	wire [7:0] chunk4;

	// Assign each chunk of output bits to the corresponding input bits
	assign chunk1 = in[7:0];
	assign chunk2 = in[15:8];
	assign chunk3 = in[23:16];
	assign chunk4 = in[31:24];

	// Concatenate the chunks to form the output
	assign out = {chunk4, chunk3, chunk2, chunk1};

endmodule
