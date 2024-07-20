module top_module(
	input clk,
	input d,
	output reg q);
	
	always @(posedge clk) begin
		if (clk'event) begin
			q <= d;
		end
	end
endmodule
