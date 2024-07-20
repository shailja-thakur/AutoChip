module top_module (
	input [31:0] in,
	output [31:0] out
);

	reg [31:0] tmp;

	always @(*) begin
		tmp[7:0] = in[31:24];
		tmp[15:8] = in[23:16];
		tmp[23:16] = in[15:8];
		tmp[31:24] = in[7:0];
	end

	assign out = tmp;

endmodule
