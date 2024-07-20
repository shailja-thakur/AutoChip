module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Declaration of internal signals
	wire [7:0] chunk_0;
	wire [7:0] chunk_1;
	wire [7:0] chunk_2;
	wire [7:0] chunk_3;

	// Assigning 8-bit chunks of input to internal signals
	assign chunk_0 = in[7:0];
	assign chunk_1 = in[15:8];
	assign chunk_2 = in[23:16];
	assign chunk_3 = in[31:24];

	// Assigning internal signals to output
	assign out = {chunk_3, chunk_2, chunk_1, chunk_0};

endmodule
