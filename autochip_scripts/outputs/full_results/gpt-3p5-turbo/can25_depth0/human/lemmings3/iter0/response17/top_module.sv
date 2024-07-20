module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);

reg [1:0] state, next_state;

parameter IDLE = 2'b00;
parameter WALK_LEFT = 2'b01;
parameter WALK_RIGHT = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= IDLE;
	elseif (state == IDLE) begin
		if (bump_left && bump_right)
			next_state <= IDLE;
		else if (bump_left)
			next_state <= WALK_RIGHT;
		else if (bump_right)
			next_state <= WALK_LEFT;
		else if (ground == 1'b0)
			next_state <= IDLE;
		else if (dig)
			next_state <= WALK_LEFT;
		else
			next_state <= WALK_LEFT;
	end elseif (state == WALK_LEFT) begin
		if (bump_left && bump_right)
			next_state <= IDLE;
		else if (bump_left)
			next_state <= WALK_RIGHT;
		else if (bump_right)
			next_state <= WALK_LEFT;
		else if (ground == 1'b0)
			next_state <= IDLE;
		else if (dig)
			next_state <= WALK_LEFT;
		else
			next_state <= WALK_LEFT;
	end elseif (state == WALK_RIGHT) begin
		if (bump_left && bump_right)
			next_state <= IDLE;
		else if (bump_left)
			next_state <= WALK_RIGHT;
		else if (bump_right)
			next_state <= WALK_LEFT;
		else if (ground == 1'b0)
			next_state <= IDLE;
		else if (dig)
			next_state <= WALK_LEFT;
		else
			next_state <= WALK_RIGHT;
	end
end

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= IDLE;
	else
		state <= next_state;
end

assign walk_left = (state == WALK_LEFT);
assign walk_right = (state == WALK_RIGHT);
assign digging = (state == WALK_LEFT && dig && ground);
assign aaah = (state == IDLE && ground == 0);

endmodule
