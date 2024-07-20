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

reg [1:0] state;
reg [1:0] next_state;
reg falling;

parameter [1:0]
	IDLE = 2'b00,
	LEFT = 2'b01,
	RIGHT = 2'b10;

always @(posedge clk, posedge areset) begin
	if (areset) begin
		state <= IDLE;
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
		digging <= 1'b0;
		falling <= 1'b0;
	end else begin
		state <= next_state;
		case (state)
			IDLE:
				if (bump_left) begin
					next_state = RIGHT;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					digging <= 0;
				end else if (bump_right) begin
					next_state = LEFT;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					digging <= 0;
				end else if (falling) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 0;
				end else if (!ground && dig) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 1'b1;
				end else if (!ground) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					falling <= 1'b1;
				end else begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 0;
				end
			LEFT:
				if (bump_right) begin
					next_state = RIGHT;
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					aaah <= 0;
					digging <= 0;
				end else if (!ground) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					aaah <= 1'b1;
					digging <= 0;
				end else if (dig) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 1'b1;
				end else begin
					next_state = LEFT;
					aaah <= 0;
					digging <= 0;
				end
			RIGHT:
				if (bump_left) begin
					next_state = LEFT;
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					aaah <= 0;
					digging <= 0;
				end else if (!ground) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					aaah <= 1'b1;
					digging <= 0;
				end else if (dig) begin
					next_state = IDLE;
					walk_left <= walk_left;
					walk_right <= walk_right;
					digging <= 1'b1;
				end else begin
					next_state = RIGHT;
					aaah <= 0;
					digging <= 0;
				end
		endcase
	end
end

endmodule
