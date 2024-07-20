module top_module(
	input clk,
	input reset,
	output reg [9:0] q);
	
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			q <= 10'b0;
		end else begin
			q <= q + 1;
		end
		if (q == 10'd999) begin
			q <= 10'b0;
		end
	end
	
endmodule
