module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

reg [1:0] state;
reg walk_left;
reg walk_right;
reg aaah;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALLING = 2'b10;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
	end else if (ground == 0) begin
		state <= FALLING;
		if (state == WALK_LEFT) begin
			walk_left <= 0;
			walk_right <= 0;
		end else if (state == WALK_RIGHT) begin
			walk_left <= 0;
			walk_right <= 1;
		end
		aaah <= 1;
	end else if (state == FALLING) begin
		state <= WALK_LEFT;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
	end else if (bump_left) begin
		state <= WALK_RIGHT;
		walk_left <= 0;
		walk_right <= 1;
		aaah <= 0;
	end else if (bump_right) begin
		state <= WALK_LEFT;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
	end
end

endmodule
