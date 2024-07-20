module top_module(
	input clk,
	input d,
	output reg q);
	
	reg q_prev;
	always @(posedge clk) begin
		q_prev <= q;
	end
	
	always @(posedge clk) begin
		if (q_prev == 1'b0 && q == 1'b1) begin
			q <= d;
		end
	end
endmodule
