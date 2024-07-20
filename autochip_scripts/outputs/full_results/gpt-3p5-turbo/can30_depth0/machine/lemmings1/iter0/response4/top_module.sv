module top_module (
	input wire clk,
	input wire areset,
	input wire bump_left,
	input wire bump_right,
	output wire walk_left,
	output wire walk_right
);
	
	parameter WL = 1;
	parameter WR = 0;
	
	reg state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WL;  // reset to initial state
		else begin
			// state transition logic
			if (state == WL) begin
				if (bump_left)
					state <= WR;
				else
					state <= WL;
			end else if (state == WR) begin
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
