module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset)
		byte1 <= 8'b0;
	else if (in[3])
		byte1 <= in;
end

always @(posedge clk or posedge reset) begin
	if (reset)
		byte2 <= 8'b0;
	else if (byte1 != 0 && byte2 == 0)
		byte2 <= in;

end

always @(posedge clk or posedge reset) begin

	if (reset)
		byte3 <= 8'b0;
	else if (byte1 != 0 && byte2 != 0 && byte3 == 0)
		byte3 <= in;
end

always @(posedge clk) begin
	if (reset)
		done_reg <= 1'b0;
	else if (byte1 != 0 && byte2 != 0 && byte3 != 0)
		done_reg <= 1'b1;
end

assign out_bytes = {byte1, byte2, byte3};
assign done = done_reg;

endmodule
