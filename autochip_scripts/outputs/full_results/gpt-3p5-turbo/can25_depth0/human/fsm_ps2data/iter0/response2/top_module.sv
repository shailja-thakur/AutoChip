module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	reg [7:0] byte1, byte2, byte3;
	reg done_reg;

always @(posedge clk) begin
	if (reset) begin
		byte1 <= 8'b0;
		byte2 <= 8'b0;
		byte3 <= 8'b0;
		done_reg <= 1'b0;
	end
	else begin
		byte1 <= byte2;
		byte2 <= byte3;
		byte3 <= in;
		if (done_reg) begin
			done_reg <= 1'b0;
		end
		else if (byte1[3] == 1'b1 && byte2[3] == 1'b0 && byte3[3] == 1'b0) begin
			done_reg <= 1'b1;
		end
	end
end

assign out_bytes = {byte1, byte2, byte3};
assign done = done_reg;

endmodule
