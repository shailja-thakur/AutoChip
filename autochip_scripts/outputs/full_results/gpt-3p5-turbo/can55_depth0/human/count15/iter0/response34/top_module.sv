module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 4'b0000;
		end else begin
			if (q == 4'b1111) begin
				q <= 4'b0000;
			end else begin
				q <= q + 4'b0001;
			end
		end
	end

endmodule
