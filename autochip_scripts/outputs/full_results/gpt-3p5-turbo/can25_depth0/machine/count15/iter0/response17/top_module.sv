module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
	
	always @(posedge clk) begin
		if (reset == 1'b1)
			q <= 4'b0;
		else
			q <= q + 1;
	end
	
endmodule
