module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

parameter WL = 1;
parameter WR = 2;

reg [1:0] state;

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
	walk_left = (state == WL);
	walk_right = (state == WR);
end

endmodule
