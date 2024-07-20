module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);

reg [2:0] state;
reg [2:0] next_state;

parameter [2:0]
	IDLE = 3'b000,
	LEFT = 3'b001,
	RIGHT = 3'b010,
	FALL = 3'b011,
	DIG = 3'b100;

always @(posedge clk, posedge areset) begin
	if (areset) begin
		state <= IDLE;
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
		digging <= 1'b0;
	end else begin
		state <= next_state;
		case (state)
			IDLE:
				if (bump_left && !bump_right) begin
					next_state = RIGHT;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
				end else if (!bump_left && bump_right) begin
					next_state = LEFT;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
				end else if (!ground && !dig) begin
					next_state = FALL;
					walk_left <= walk_left;
					walk_right <= walk_right;
				end else if (!ground && dig) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 1'b1;
				end else if (ground && dig) begin
					next_state = DIG;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 1'b1;
				end else begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
				end
			LEFT:
				if (bump_right) begin
					next_state = RIGHT;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					digging <= 1'b0;
				end else if (!ground) begin
					next_state = FALL;
					walk_left <= walk_left;
					walk_right <= walk_right;
					aaah <= 1'b1;
				end else if (dig) begin
					next_state = DIG;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 1'b1;
				end else begin
					next_state = LEFT;
				end
			RIGHT:
				if (bump_left) begin
					next_state = LEFT;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					digging <= 1'b0;
				end else if (!ground) begin
					next_state = FALL;
					walk_left <= walk_left;
					walk_right <= walk_right;
					aaah <= 1'b1;
				end else if (dig) begin
					next_state = DIG;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 1'b1;
				end else begin
					next_state = RIGHT;
				end
			FALL:
				if (ground && !bump_left && !bump_right) begin
					next_state = state;
					walk_left <= walk_left;
					walk_right <= walk_right;
				end else begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
				end
			DIG:
				if (!ground) begin
					next_state = FALL;
					walk_left <= walk_left;
					walk_right <= walk_right;
					aaah <= 1'b1;
				end else begin
					next_state = state;
					walk_left <= walk_left;
					walk_right <= walk_right;
				end
		endcase
	end
end

endmodule
