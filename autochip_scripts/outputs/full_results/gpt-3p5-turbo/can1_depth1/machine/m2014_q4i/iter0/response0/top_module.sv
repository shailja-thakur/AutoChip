module top_module(
	output reg out);
	
	always @(posedge clk or negedge rst) begin
		if (rst == 1'b0)
			out <= 1'b0;
		else
			out <= 1'b0;
	end
	
endmodule
