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
	typedef enum reg [2:0] {
		LEFT = 3'b000,       // Walking left
		RIGHT = 3'b001,      // Walking right
		FALL_LEFT = 3'b010,  // Falling while walking left
		FALL_RIGHT = 3'b011, // Falling while walking right
		DIG_LEFT = 3'b100,   // Digging while walking left
		DIG_RIGHT = 3'b101,  // Digging while walking right
		SPLAT = 3'b110       // Splat (terminal state)
	} state_t;

	state_t current_state, next_state;

	// Counter for falling duration
	reg [4:0] fall_time;

	// State transition
	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= LEFT;
			fall_time <= 0;
		end
		else begin
			current_state <= next_state;

			if (current_state == FALL_LEFT || current_state == FALL_RIGHT) begin
				// Increment fall_time if falling
				fall_time <= fall_time + 1;
			end
			else if (ground) begin
				// Reset fall_time if on the ground and not falling
				fall_time <= 0;
			end
		end
	end

	// Next state logic
	always @ (*) begin
		case (current_state)
			LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else if (dig)
					next_state = DIG_LEFT;
				else if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end

			RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else if (dig)
					next_state = DIG_RIGHT;
				else if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end

			FALL_LEFT: begin
				if (ground) begin
					if (fall_time > 20)
						next_state = SPLAT;
					else
						next_state = LEFT;
				end
				else
					next_state = FALL_LEFT;
			end

			FALL_RIGHT: begin
				if (ground) begin
					if (fall_time > 20)
						next_state = SPLAT;
					else
						next_state = RIGHT;
				end
				else
					next_state = FALL_RIGHT;
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

			SPLAT: begin
				next_state = SPLAT;
			end

			default: next_state = LEFT;
		endcase
	end

	// Output logic
	always @ (*) begin
		// Default outputs
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;

		case (current_state)
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

			SPLAT: begin
				// All signals should be 0
			end
		endcase
	 end
endmodule
