module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	always @(posedge clk or posedge areset)
	begin
		if (areset)
		begin
			walk_left <= 1'b1; // reset to walking left
			walk_right <= 1'b0;
		end
		else
		begin
			if (bump_left && bump_right)
			begin
				walk_left <= 1'b1; // switch directions
				walk_right <= 1'b0;
			end
			else if (bump_left)
			begin
				walk_left <= 1'b0; // walk right
				walk_right <= 1'b1;
			end
			else if (bump_right)
			begin
				walk_left <= 1'b1; // walk left
				walk_right <= 1'b0;
			end
			else
			begin
				if (walk_left) // continue walking left
				begin
					walk_left <= 1'b1;
					walk_right <= 1'b0;
				end
				else if (walk_right) // continue walking right
				begin
					walk_left <= 1'b0;
					walk_right <= 1'b1;
				end
			end
		end
	end

endmodule
