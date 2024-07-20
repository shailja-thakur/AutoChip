module top_module(
	output reg out);
	
	always @(posedge clk or negedge rst) begin
		if (!rst)
			out <= 0;
		else
			out <= 0;
	end
	
endmodule
