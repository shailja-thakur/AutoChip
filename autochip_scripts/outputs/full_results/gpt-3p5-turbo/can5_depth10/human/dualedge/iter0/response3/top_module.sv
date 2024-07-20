module top_module(
	input clk,
	input d,
	output reg q);
	
	always @(posedge clk)
	begin
		if(clk == 1)
			q <= d;
	end
	
	always @(negedge clk)
	begin
		if(clk == 0)
			q <= d;
	end
	
endmodule
