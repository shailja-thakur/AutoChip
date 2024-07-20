module top_module (
	input [31:0] in,
	output [31:0] out
);

reg [31:0] temp;

always @(*) begin
	temp[7:0] = in[31:24];
	temp[15:8] = in[23:16];
	temp[23:16] = in[15:8];
	temp[31:24] = in[7:0];
	out = temp;
end

endmodule
