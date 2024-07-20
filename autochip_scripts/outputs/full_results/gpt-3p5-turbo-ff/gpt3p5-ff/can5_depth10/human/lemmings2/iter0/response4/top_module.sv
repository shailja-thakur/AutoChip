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
	// Define the states
	typedef enum logic [1:0] {
		WALKING_LEFT,
		WALKING_RIGHT,
		FALLING
	} state_t;

	// Define the internal signals
	state_t state_reg;
	state_t state_next;

	// Define the outputs
	assign walk_left = (state_reg == WALKING_LEFT);
	assign walk_right = (state_reg == WALKING_RIGHT);
	assign aaah = (state_reg == FALLING);

	// Define the state transition logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= WALKING_LEFT;
		end else begin
			state_reg <= state_next;
		end
	end

	// Define the next state logic
	always_comb begin
		state_next = state_reg;

		case (state_reg)
			WALKING_LEFT: begin
				if (bump_right) begin
					state_next = WALKING_RIGHT;
				end else if (!ground) begin
					state_next = FALLING;
				end
			end

			WALKING_RIGHT: begin
				if (bump_left) begin
					state_next = WALKING_LEFT;
				end else if (!ground) begin
					state_next = FALLING;
				end
			end

			FALLING: begin
				if (ground) begin
					if (state_reg == WALKING_LEFT) begin
						state_next = WALKING_LEFT;
					end else if (state_reg == WALKING_RIGHT) begin
						state_next = WALKING_RIGHT;
					end
				end
			end
		endcase
	end
endmodule
