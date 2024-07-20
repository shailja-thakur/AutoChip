module top_module(
	input clk,
	input d,
	output reg q);
	
	reg d1, d2;
	always @(posedge clk)
	begin
		d1 <= d;
		d2 <= d1;
	end
	
	always @(negedge clk)
	begin
		q <= d2;
	end
	
endmodule
