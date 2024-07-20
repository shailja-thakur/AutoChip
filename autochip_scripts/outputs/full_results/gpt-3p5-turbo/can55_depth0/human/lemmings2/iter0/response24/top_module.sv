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

	// State definitions
	typedef enum logic [1:0] {
		ST_WALK_LEFT,
		ST_WALK_RIGHT,
		ST_FALL,
		ST_RESUME_LEFT,
		ST_RESUME_RIGHT
	} StateType;

	reg [1:0] state;
	reg [1:0] next_state;

	// Outputs
	reg walk_left;
	reg walk_right;
	reg aaah;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset state machine to walk left
			state <= ST_WALK_LEFT;
		end else begin
			// Update next state based on current state and inputs
			case (state)
				ST_WALK_LEFT: begin
					if (bump_right) begin
						next_state <= ST_WALK_RIGHT;
					end else if (ground) begin
						next_state <= ST_WALK_LEFT;
					end else begin
						next_state <= ST_FALL;
					end
				end
				ST_WALK_RIGHT: begin
					if (bump_left) begin
						next_state <= ST_WALK_LEFT;
					end else if (ground) begin
						next_state <= ST_WALK_RIGHT;
					end else begin
						next_state <= ST_FALL;
					end
				end
				ST_FALL: begin
					if (ground) begin
						if (state == ST_WALK_LEFT) begin
							next_state <= ST_RESUME_LEFT;
						end else begin
							next_state <= ST_RESUME_RIGHT;
						end
					end else begin
						next_state <= ST_FALL;
					end
				end
				ST_RESUME_LEFT: begin
					if (bump_right) begin
						next_state <= ST_WALK_RIGHT;
					end else begin
						next_state <= ST_RESUME_LEFT;
					end
				end
				ST_RESUME_RIGHT: begin
					if (bump_left) begin
						next_state <= ST_WALK_LEFT;
					end else begin
						next_state <= ST_RESUME_RIGHT;
					end
				end
				default: next_state <= ST_WALK_LEFT;
			endcase
		end
	end

	always @(posedge clk) begin
		if (areset) begin
			// Reset outputs
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
		end else begin
			// Update outputs based on current state
			case (state)
				ST_WALK_LEFT: begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end
				ST_WALK_RIGHT: begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end
				ST_FALL: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end
				ST_RESUME_LEFT: begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end
				ST_RESUME_RIGHT: begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end
				default: begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end
			endcase
		end
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= ST_WALK_LEFT;
		end else begin
			state <= next_state;
		end
	end

endmodule
