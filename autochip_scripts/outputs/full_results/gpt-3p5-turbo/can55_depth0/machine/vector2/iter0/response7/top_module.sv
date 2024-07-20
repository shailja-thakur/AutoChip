module top_module (
	input [31:0] in,
	output [31:0] out
);
	reg [7:0] out0, out1, out2, out3;

	always @ (*) begin
		out0 = in[7:0];
		out1 = in[15:8];
		out2 = in[23:16];
		out3 = in[31:24];
		out = {out3, out2, out1, out0};
	end

endmodule
