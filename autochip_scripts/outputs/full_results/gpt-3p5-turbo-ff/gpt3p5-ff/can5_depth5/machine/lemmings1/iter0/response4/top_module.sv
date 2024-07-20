module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	parameter WL = 1'b0;
	parameter WR = 1'b1;
	
	reg state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WL;
		else begin
			if (state == WL)
				state <= (bump_left) ? WR : WL;
			else if (state == WR)
				state <= (bump_right) ? WL : WR;
		end
	end
	
	always @(state) begin
		if (state == WL) begin
			walk_left <= 1'b1;
			walk_right <= 1'b0;
		end
		else if (state == WR) begin
			walk_left <= 1'b0;
			walk_right <= 1'b1;
		end
	end

endmodule
