module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);
	
	always @(posedge clk) begin
		if (clk) begin
			q <= d;
		end
	end
endmodule
