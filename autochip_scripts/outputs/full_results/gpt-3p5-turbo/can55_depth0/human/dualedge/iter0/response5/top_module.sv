module top_module(
	input clk,
	input d,
	output reg q);
	
	reg q_delay1, q_delay2;
	always @(posedge clk) begin
		q_delay1 <= d;
		q_delay2 <= q_delay1;
		q <= q_delay2;
	end
endmodule
