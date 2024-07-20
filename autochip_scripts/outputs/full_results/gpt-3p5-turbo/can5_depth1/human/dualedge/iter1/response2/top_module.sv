module top_module(
	input clk,
	input d,
	output reg q);

	reg q1;
	always @(posedge clk or negedge clk) begin
		if (~clk)
			q1 <= d;
	end
	
	always @(posedge clk or negedge clk) begin
		if (clk)
			q <= q1;
	end

endmodule
