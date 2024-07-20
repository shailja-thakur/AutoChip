module top_module(
	input clk,
	input d,
	output reg q);

	/* Variables to store the previous and current clock values */
	reg prev_clk;
	reg curr_clk;
	
	/* Flip-flop functionality "if" statement */
	always @(posedge clk) begin
		prev_clk <= curr_clk;
		curr_clk <= clk;
		
		if (prev_clk == 1'b0 && curr_clk == 1'b1) begin
			q <= d;
		end
	end
endmodule
