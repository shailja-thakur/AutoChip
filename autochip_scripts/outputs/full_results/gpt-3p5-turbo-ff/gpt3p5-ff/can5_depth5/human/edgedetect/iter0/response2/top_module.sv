module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	always @(posedge clk) begin
		for (int i = 0; i < 8; i = i + 1) begin
			if (in[i] == 1'b0 && in[i+1] == 1'b1) begin
				pedge[i] <= 1'b1;
			end
			else begin
				pedge[i] <= 1'b0;
			end
		end
	end

endmodule
