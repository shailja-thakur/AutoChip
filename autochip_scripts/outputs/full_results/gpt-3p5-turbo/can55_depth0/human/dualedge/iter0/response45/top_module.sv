module top_module(
	input clk,
	input d,
	output reg q);
	
	reg q_reg;
	
	always @(posedge clk or negedge clk)
	begin
		if (clk)
			q_reg <= d;
	end
	
	always @(posedge clk)
	begin
		q <= q_reg;
	end
	
endmodule
