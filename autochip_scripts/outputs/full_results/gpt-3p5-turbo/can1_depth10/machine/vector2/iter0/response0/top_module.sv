module top_module (
	input [31:0] in,
	output [31:0] out
);
	
	// Wire declaration
	wire [7:0] chunk1, chunk2, chunk3, chunk4;
	
	// Assign each 8-bit chunk of input to respective chunks 
	assign chunk1 = in[7:0];
	assign chunk2 = in[15:8];
	assign chunk3 = in[23:16];
	assign chunk4 = in[31:24];

	// Connect the chunks to the output
	assign out = {chunk4, chunk3, chunk2, chunk1};

endmodule
