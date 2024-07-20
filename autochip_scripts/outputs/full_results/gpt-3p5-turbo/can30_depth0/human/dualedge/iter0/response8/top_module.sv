module top_module(
	input clk,
	input d,
	output reg q);

	reg q_ff;
	always @(posedge clk) begin
		q_ff <= d;
	end
	
	always @(negedge clk) begin
		q <= q_ff;
	end

endmodule
