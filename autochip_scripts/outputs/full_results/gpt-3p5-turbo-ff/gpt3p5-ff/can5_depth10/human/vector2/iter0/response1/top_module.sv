module top_module (
	input [31:0] in,
	output [31:0] out
);

	reg [31:0] reverse;

	always @(*) begin
		reverse[7:0] = in[31:24];
		reverse[15:8] = in[23:16];
		reverse[23:16] = in[15:8];
		reverse[31:24] = in[7:0];
	end

	assign out = reverse;

endmodule
