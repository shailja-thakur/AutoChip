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
parameter FALL = 2'b10;
parameter BUMP_LEFT = 2'b11;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= WALK_LEFT;
	else if (state == WALK_LEFT && bump_right)
		state <= WALK_RIGHT;
	else if (state == WALK_RIGHT && bump_left)
		state <= WALK_LEFT;
	else if (state == WALK_LEFT && bump_left && bump_right)
		state <= WALK_RIGHT;
	else if (state == FALL && ground)
		state <= (state == BUMP_LEFT) ? WALK_RIGHT : WALK_LEFT;
	else if (!ground && (state == WALK_LEFT || state == WALK_RIGHT))
		state <= FALL;
	else if (state == WALK_LEFT || state == WALK_RIGHT || state == BUMP_LEFT)
		state <= state;
end

always @*
begin
	case (state)
		WALK_LEFT: begin
			walk_left = 1;
			walk_right = 0;
			aaah = 0;
		end
		WALK_RIGHT: begin
			walk_left = 0;
			walk_right = 1;
			aaah = 0;
		end
		FALL: begin
			walk_left = (state == BUMP_LEFT) ? 1 : 0;
			walk_right = (state == BUMP_LEFT) ? 0 : 1;
			aaah = 1;
		end
		BUMP_LEFT: begin
			walk_left = 0;
			walk_right = 1;
			aaah = 0;
		end
	endcase
end

endmodule
