module top_module(
	input clk,
	input d,
	output reg q); 

	reg q_d;
	always @(posedge clk) begin
		q_d <= d;
	end
	
	always @(negedge clk) begin
		q <= q_d;
	end
endmodule
