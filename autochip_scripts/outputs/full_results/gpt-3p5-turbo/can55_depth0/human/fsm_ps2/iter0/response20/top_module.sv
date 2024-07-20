module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		byte1 <= 8'b0;
		byte2 <= 8'b0;
		byte3 <= 8'b0;
		done_reg <= 1'b0;
	end else begin
		byte1 <= byte2;
		byte2 <= byte3;
		byte3 <= in;
		
		if (byte1[3] && ~byte2[3] && ~byte3[3]) begin
			done_reg <= 1'b1;
		end else begin
			done_reg <= 1'b0;
		end
	end
end

assign done = done_reg;

endmodule
