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
always @(posedge clk or posedge areset) begin
	if (areset)
		state <= WL;
	else
		state <= (state == WL && bump_left) ? WR :
		         (state == WR && bump_right) ? WL :
		         state;
end

assign walk_left = (state == WL);
assign walk_right = (state == WR);

endmodule
