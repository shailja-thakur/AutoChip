module top_module(
	output reg out,
	input wire clk,
	input wire rst);
	
	always @(posedge clk or negedge rst) begin
		if (!rst)
			out <= 1'b0;
		else
			out <= 1'b0;
	end
	
endmodule
