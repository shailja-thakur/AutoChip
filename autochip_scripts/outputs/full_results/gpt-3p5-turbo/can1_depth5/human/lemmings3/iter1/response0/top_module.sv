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
	// Define states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG
	} state_t;
	
	// Define state register and next state
	reg state_t current_state;
	reg state_t next_state;
	
	// Reset the state machine on positive edge of areset signal
	always @(posedge areset) begin
		current_state <= WALK_LEFT;
	end
	
	// State transition and output logic
	always @(posedge clk) begin
		if (areset) begin
			// Reset outputs
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
			
			// Reset states
			current_state <= WALK_LEFT;
			next_state <= WALK_LEFT;
		end else begin
			// Determine next state
			case (current_state)
				WALK_LEFT:
					if (bump_right) begin
						next_state <= WALK_RIGHT;
					end else if (dig) begin
						next_state <= DIG;
					end else if (ground == 0) begin
						next_state <= FALL;
					end else begin
						next_state <= WALK_LEFT;
					end
					
				WALK_RIGHT:
					if (bump_left) begin
						next_state <= WALK_LEFT;
					end else if (dig) begin
						next_state <= DIG;
					end else if (ground == 0) begin
						next_state <= FALL;
					end else begin
						next_state <= WALK_RIGHT;
					end
					
				FALL:
					if (ground) begin
						next_state <= current_state;
					end else begin
						next_state <= FALL;
					end
					
				DIG:
					if (ground) begin
						next_state <= FALL;
					end else if (bump_left || bump_right) begin
						next_state <= FALL;
					end else begin
						next_state <= DIG;
					end
					
				default:
					next_state <= WALK_LEFT;
			endcase
			
			// Update current state
			current_state <= next_state;
			
			// Update outputs based on current state
			case (current_state)
				WALK_LEFT:
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
				
				WALK_RIGHT:
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;
					
				FALL:
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					
				DIG:
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
			endcase
		end
	end
endmodule
