module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			walk_left <= 1'b1;
			walk_right <= 1'b0;
		end
		else begin
			if (bump_left && !bump_right)
				walk_left <= 1'b0;
			else if (!bump_left && bump_right)
				walk_right <= 1'b0;
			else if (bump_left && bump_right)
				walk_left <= 1'b0;
			else if (!bump_left && !bump_right)
				walk_right <= 1'b1;
		end
	end
endmodule
