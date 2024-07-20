module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	
	parameter WL = 1'b0;
	parameter WR = 1'b1;
	reg state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WL;
		else begin
			if (state == WL) begin
				if (bump_left)
					state <= WR;
				else
					state <= WL;
			end else begin
				if (bump_right)
					state <= WL;
				else
					state <= WR;
			end
		end
	end
	
	assign walk_left = (state == WL) ? 1'b1 : 1'b0;
	assign walk_right = (state == WR) ? 1'b1 : 1'b0;
	
endmodule
