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

	// State encoding
	typedef enum logic [2:0] {
		WALK_LEFT     = 3'b000,
		WALK_RIGHT    = 3'b001,
		FALL_LEFT     = 3'b010,
		FALL_RIGHT    = 3'b011,
		DIG_LEFT      = 3'b100,
		DIG_RIGHT     = 3'b101,
		SPLATTER      = 3'b110
	} state_t;

	state_t state, next_state;
	reg [4:0] fall_count; // 5-bit counter to count up to 32 cycles

	// State transition logic
	always @(*) begin
		case (state)
			WALK_LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else if (dig)
					next_state = DIG_LEFT;
				else if (bump_left)
					next_state = WALK_RIGHT;
				else
					next_state = WALK_LEFT;
			end
			WALK_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else if (dig)
					next_state = DIG_RIGHT;
				else if (bump_right)
					next_state = WALK_LEFT;
				else
					next_state = WALK_RIGHT;
			end
			FALL_LEFT, FALL_RIGHT: begin
				if (ground && fall_count > 5'd20)
					next_state = SPLATTER;
				else if (ground && fall_count <= 5'd20)
					next_state = (state == FALL_LEFT) ? WALK_LEFT : WALK_RIGHT;
				else
					next_state = state;
			end
			DIG_LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else
					next_state = DIG_LEFT;
			end
			DIG_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else
					next_state = DIG_RIGHT;
			end
			SPLATTER: begin
				next_state = SPLATTER;
			end
			default: next_state = WALK_LEFT;
		endcase
	end

	// State register and fall counter
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			fall_count <= '0;
		end else begin
			state <= next_state;
			if (state == FALL_LEFT || state == FALL_RIGHT)
				fall_count <= fall_count + 1;
			else
				fall_count <= '0;
		end
	end

	// Output logic
	always @(*) begin
		case (state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			FALL_LEFT, FALL_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			DIG_LEFT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			DIG_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			SPLATTER: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			default: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

endmodule
