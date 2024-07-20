module top_module(
	input clk,
	input d,
	output reg q);

	reg d_ff;
	reg q_ff;

	always @(posedge clk)
	begin
		d_ff <= d;
	end

	always @(negedge clk)
	begin
		q_ff <= d_ff;
	end

	always @(posedge clk or negedge clk)
	begin
		q <= q_ff;
	end
endmodule
