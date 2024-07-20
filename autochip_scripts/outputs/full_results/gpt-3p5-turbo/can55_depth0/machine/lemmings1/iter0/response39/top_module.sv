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
always @(posedge clk, posedge areset)
begin
	if (areset)
		state <= WL;
	else if (state == WL && bump_left)
		state <= WR;
	else if (state == WR && bump_right)
		state <= WL;
	else
		state <= state;
end

assign walk_left = (state == WL) ? 1 : 0;
assign walk_right = (state == WR) ? 1 : 0;

endmodule
