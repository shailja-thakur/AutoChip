module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Wire declarations
	wire [7:0] chunk_1;
	wire [7:0] chunk_2;
	wire [7:0] chunk_3;
	wire [7:0] chunk_4;
	
	// Assign each chunk of the input to the corresponding chunk of the output
	assign chunk_1 = in[7:0];
	assign chunk_2 = in[15:8];
	assign chunk_3 = in[23:16];
	assign chunk_4 = in[31:24];
	
	// Assign the rearranged chunks to the output
	assign out = {chunk_4, chunk_3, chunk_2, chunk_1};

endmodule
