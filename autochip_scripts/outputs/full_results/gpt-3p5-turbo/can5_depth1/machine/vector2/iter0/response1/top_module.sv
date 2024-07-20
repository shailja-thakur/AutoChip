module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Define intermediate signals
	wire [7:0] chunk0;
	wire [7:0] chunk1;
	wire [7:0] chunk2;
	wire [7:0] chunk3;

	// Split input into chunks
	assign chunk0 = in[7:0];
	assign chunk1 = in[15:8];
	assign chunk2 = in[23:16];
	assign chunk3 = in[31:24];

	// Reorder chunks
	assign out = {chunk3, chunk2, chunk1, chunk0};
	
endmodule
