module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	
	parameter WL = 0;
	parameter WR = 1;
	
	reg state;
	
	always @(posedge clk or posedge areset)
		if (areset)
			state <= WL;
		else
			if (state == WL)
				if (bump_left)
					state <= WR;
				else
					state <= WL;
			else
				if (bump_right)
					state <= WL;
				else
					state <= WR;
	
	assign walk_left = (state == WL);
	assign walk_right = (state == WR);
endmodule
