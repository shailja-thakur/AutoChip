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
	// Define the states
	typedef enum logic [2:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG
	} state_t;
	
	reg state_t current_state;
	reg state_t next_state;
	
	// Define the outputs
	reg walk_left;
	reg walk_right;
	reg aaah;
	reg digging;
	
	// Define the internal signals
	reg fall;
	reg bump;
	
	// FSM
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset the FSM
			current_state <= WALK_LEFT;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
			next_state <= WALK_LEFT;
		end else begin
			// Update next state based on the current state and input signals
			case (current_state)
				WALK_LEFT: begin
					if (bump_right) begin
						next_state <= WALK_RIGHT;
					end else if (!ground && !fall) begin
						next_state <= FALL;
					end else if (dig && ground) begin
						next_state <= DIG;
					end else begin
						next_state <= WALK_LEFT;
					end
				end
				WALK_RIGHT: begin
					if (bump_left) begin
						next_state <= WALK_LEFT;
					end else if (!ground && !fall) begin
						next_state <= FALL;
					end else if (dig && ground) begin
						next_state <= DIG;
					end else begin
						next_state <= WALK_RIGHT;
					end
				end
				FALL: begin
					if (ground) begin
						next_state <= current_state;
					end else begin
						next_state <= FALL;
					end
				end
				DIG: begin
					if (ground && !fall) begin
						next_state <= WALK_LEFT;
					end else if (!ground && !fall) begin
						next_state <= FALL;
					end else begin
						next_state <= DIG;
					end
				end
				default: next_state <= WALK_LEFT;
			endcase
		end
	end
	
	// Assign outputs based on current state
	always @(current_state, ground, fall) begin
		case (current_state)
			WALK_LEFT: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
			WALK_RIGHT: begin
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;
			end
			FALL: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 1;
				digging <= 0;
			end
			DIG: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 1;
			end
			default: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
		endcase
	end
endmodule
