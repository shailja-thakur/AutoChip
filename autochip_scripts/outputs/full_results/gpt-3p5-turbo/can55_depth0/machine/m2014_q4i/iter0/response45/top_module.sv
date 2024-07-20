module top_module(
	output reg out);
	
	always @(posedge clk or negedge reset) begin
		if (reset == 0)
			out <= 0;
		else
			out <= 1'b0;
	end
	
endmodule
