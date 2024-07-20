module top_module (
	input [31:0] in,
	output [31:0] out
);

	reg [7:0] chunk1, chunk2, chunk3, chunk4;

	always @(*) begin
		chunk1 = in[7:0];
		chunk2 = in[15:8];
		chunk3 = in[23:16];
		chunk4 = in[31:24];

		out = {chunk4, chunk3, chunk2, chunk1};
	end
endmodule
