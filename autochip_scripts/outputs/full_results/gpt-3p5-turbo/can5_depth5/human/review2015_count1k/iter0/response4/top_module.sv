module top_module(
	input clk,
	input reset,
	output reg [9:0] q);
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
		end else begin
			if (q < 999) begin
				q <= q + 1;
			end else begin
				q <= 0;
			end
		end
	end
	
endmodule
