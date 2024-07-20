module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Declare internal signals
	reg [7:0] chunk0;
	reg [7:0] chunk1;
	reg [7:0] chunk2;
	reg [7:0] chunk3;
	reg [31:0] temp;

	// Assign input bits to the output chunks
	always @(in) begin
		chunk0 = in[7:0];
		chunk1 = in[15:8];
		chunk2 = in[23:16];
		chunk3 = in[31:24];
		temp = {chunk3, chunk2, chunk1, chunk0};
	end

	// Assign the rearranged chunks to the output
	assign out = temp;

endmodule
