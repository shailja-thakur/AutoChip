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

typedef enum reg [2:0] {
	LEFT = 3'b000,
	RIGHT = 3'b001,
	FALL_LEFT = 3'b010,
	FALL_RIGHT = 3'b011,
	DIGGING_LEFT = 3'b100,
	DIGGING_RIGHT = 3'b101
} state_t;

reg [2:0] state, next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= LEFT;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		LEFT: begin
			if (~ground) begin
				next_state = FALL_LEFT;
			} else if (dig) begin
				next_state = DIGGING_LEFT;
			} else if (bump_left) begin
				next_state = RIGHT;
			} else begin
				next_state = LEFT;
			end
		end
		RIGHT: begin
			if (~ground) begin
				next_state = FALL_RIGHT;
			} else if (dig) begin
				next_state = DIGGING_RIGHT;
			} else if (bump_right) begin
				next_state = LEFT;
			} else begin
				next_state = RIGHT;
			end
		end
		FALL_LEFT: begin
			if (ground) begin
				next_state = LEFT;
			} else begin
				next_state = FALL_LEFT;
			end
		end
		FALL_RIGHT: begin
			if (ground) begin
				next_state = RIGHT;
			} else begin
				next_state = FALL_RIGHT;
			end
		end
		DIGGING_LEFT: begin
			if (~ground) begin
				next_state = FALL_LEFT;
			} else begin
				next_state = DIGGING_LEFT;
			end
		end
		DIGGING_RIGHT: begin
			if (~ground) begin
				next_state = FALL_RIGHT;
			} else begin
				next_state = DIGGING_RIGHT;
			end
		end
		default: begin
			next_state = LEFT;
		end
	endcase
end

always @(*) begin
	walk_left = (state == LEFT);
	walk_right = (state == RIGHT);
	aaah = (state == FALL_LEFT) || (state == FALL_RIGHT);
	digging = (state == DIGGING_LEFT) || (state == DIGGING_RIGHT);
end

endmodule
