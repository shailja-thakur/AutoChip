module top_module(
	input clk,
	input d,
	output reg q);
	
	reg q_q;
	always @(posedge clk) begin
		q_q <= d;
	end
	
	always @(negedge clk) begin
		q <= q_q;
	end
endmodule
