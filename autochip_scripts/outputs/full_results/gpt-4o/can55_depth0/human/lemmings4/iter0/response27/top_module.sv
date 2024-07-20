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

	// States
	typedef enum reg [3:0] {
		LEFT = 4'd0,
		RIGHT = 4'd1,
		FALL_LEFT = 4'd2,
		FALL_RIGHT = 4'd3,
		DIG_LEFT = 4'd4,
		DIG_RIGHT = 4'd5,
		SPLATTER = 4'd6
	} state_t;

	state_t state, next_state;
	reg [4:0] fall_count;

	// State transition logic
	always @(*) begin
		case (state)
			LEFT: begin
				if (!ground) next_state = FALL_LEFT;
				else if (dig) next_state = DIG_LEFT;
				else if (bump_left) next_state = RIGHT;
				else next_state = LEFT;
			end
			RIGHT: begin
				if (!ground) next_state = FALL_RIGHT;
				else if (dig) next_state = DIG_RIGHT;
				else if (bump_right) next_state = LEFT;
				else next_state = RIGHT;
			end
			FALL_LEFT: begin
				if (ground) next_state = (fall_count > 20) ? SPLATTER : LEFT;
				else next_state = FALL_LEFT;
			end
			FALL_RIGHT: begin
				if (ground) next_state = (fall_count > 20) ? SPLATTER : RIGHT;
				else next_state = FALL_RIGHT;
			end
			DIG_LEFT: begin
				if (!ground) next_state = FALL_LEFT;
				else next_state = DIG_LEFT;
			end
			DIG_RIGHT: begin
				if (!ground) next_state = FALL_RIGHT;
				else next_state = DIG_RIGHT;
			end
			SPLATTER: next_state = SPLATTER;
			default: next_state = LEFT;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
			fall_count <= 0;
		end else begin
			if (state == FALL_LEFT || state == FALL_RIGHT) begin
				fall_count <= fall_count + 1;
			end else begin
				fall_count <= 0;
			end
			state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;

		case (state)
			LEFT: begin
				walk_left = 1;
			end
			RIGHT: begin
				walk_right = 1;
			end
			FALL_LEFT, FALL_RIGHT: begin
				aaah = 1;
			end
			DIG_LEFT: begin
				digging = 1;
			end
			DIG_RIGHT: begin
				digging = 1;
			end
			SPLATTER: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

endmodule
