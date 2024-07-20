module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

parameter WL = 0;
parameter WR = 1;

reg state;

always @(posedge clk or posedge areset) begin
	if (areset == 1) begin
		state <= WL;
	end else begin
		if (state == WL) begin
			state <= (bump_left == 1) ? WR : WL;
		end else begin
			state <= (bump_right == 1) ? WL : WR;
		end
	end
end

always @* begin
	walk_left = (state == WL) ? 1'b1 : 1'b0;
	walk_right = (state == WR) ? 1'b1 : 1'b0;
end

endmodule
