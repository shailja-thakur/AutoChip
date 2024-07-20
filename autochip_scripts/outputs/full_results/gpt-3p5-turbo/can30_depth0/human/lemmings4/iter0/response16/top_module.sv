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

	// Define the states of the finite state machine
	typedef enum logic [2:0] {
		IDLE,
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG,
		SPLATTER
	} state_t;

	// Define the internal signals
	reg state_t current_state;
	reg state_t next_state;

	// Define the outputs
	assign walk_left = (current_state == WALK_LEFT);
	assign walk_right = (current_state == WALK_RIGHT);
	assign aaah = (current_state == FALL || current_state == SPLATTER);
	assign digging = (current_state == DIG);

	// Define the state transitions and outputs
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			current_state <= next_state;
		end
	end

	// Define the next state logic and state transitions
	always_comb begin
		next_state = current_state;

		case (current_state)
			IDLE: begin
				if (areset) begin
					next_state = WALK_LEFT;
				end else if (bump_right) begin
					next_state = WALK_LEFT;
				end else if (bump_left) begin
					next_state = WALK_RIGHT;
				end else if (ground == 0) begin
					next_state = FALL;
				end else if (dig) begin
					next_state = DIG;
				end
			end

			WALK_LEFT: begin
				if (areset) begin
					next_state = WALK_LEFT;
				end else if (bump_right) begin
					next_state = WALK_LEFT;
				end else if (bump_left && ground) begin
					next_state = WALK_RIGHT;
				end else if (ground == 0) begin
					next_state = FALL;
				end else if (dig) begin
					next_state = DIG;
				end
			end

			WALK_RIGHT: begin
				if (areset) begin
					next_state = WALK_LEFT;
				end else if (bump_left) begin
					next_state = WALK_RIGHT;
				end else if (bump_right && ground) begin
					next_state = WALK_LEFT;
				end else if (ground == 0) begin
					next_state = FALL;
				end else if (dig) begin
					next_state = DIG;
				end
			end

			FALL: begin
				if (areset) begin
					next_state = WALK_LEFT;
				end else if (ground) begin
					next_state = current_state;
				end else if (current_state == FALL && aaah) begin
					next_state = SPLATTER;
				end else if (dig) begin
					next_state = DIG;
				end
			end

			DIG: begin
				if (areset) begin
					next_state = WALK_LEFT;
				end else if (ground) begin
					next_state = current_state;
				end else if (ground == 0) begin
					next_state = FALL;
				end
			end

			SPLATTER: begin
				// No state transitions from SPLATTER, stays in this state forever
			end
		endcase
	end

endmodule
