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
	// Define states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG,
	} state_t;
	
	// Define state register and next state
	reg state_t current_state;
	reg state_t next_state;
	
	// Define output registers
	reg walk_left_reg;
	reg walk_right_reg;
	reg aaah_reg;
	reg digging_reg;
	
	// Define internal signals
	reg fall_triggered;
	reg dig_triggered;
	reg bump_triggered;
	
	// Reset the state machine on positive edge of areset signal
	always @(posedge areset) begin
		current_state <= WALK_LEFT;
	end
	
	// State transition and output logic
	always @(posedge clk) begin
		if (areset) begin
			// Reset internal signals
			fall_triggered <= 0;
			dig_triggered <= 0;
			bump_triggered <= 0;
			
			// Reset outputs
			walk_left_reg <= 1;
			walk_right_reg <= 0;
			aaah_reg <= 0;
			digging_reg <= 0;
			
			// Reset states
			current_state <= WALK_LEFT;
			next_state <= WALK_LEFT;
		end else begin
			// Determine next state
			case (current_state)
				WALK_LEFT:
					if (bump_right) begin
						next_state <= WALK_RIGHT;
						bump_triggered <= 1;
					end else if (dig) begin
						next_state <= DIG;
						dig_triggered <= 1;
					end else if (fall_triggered || (ground == 0)) begin
						next_state <= FALL;
					end else begin
						next_state <= WALK_LEFT;
					end
					
				WALK_RIGHT:
					if (bump_left) begin
						next_state <= WALK_LEFT;
						bump_triggered <= 1;
					end else if (dig) begin
						next_state <= DIG;
						dig_triggered <= 1;
					end else if (fall_triggered || (ground == 0)) begin
						next_state <= FALL;
					end else begin
						next_state <= WALK_RIGHT;
					end
					
				FALL:
					if (ground) begin
						next_state <= current_state;
						fall_triggered <= 0;
					end else begin
						next_state <= FALL;
					end
					
				DIG:
					if (!ground) begin
						next_state <= FALL;
					end else if (bump_left || bump_right || fall_triggered) begin
						next_state <= FALL;
						bump_triggered <= 1;
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
					walk_left_reg <= 1;
					walk_right_reg <= 0;
					aaah_reg <= 0;
					digging_reg <= 0;
				
				WALK_RIGHT:
					walk_left_reg <= 0;
					walk_right_reg <= 1;
					aaah_reg <= 0;
					digging_reg <= 0;
					
				FALL:
					walk_left_reg <= 0;
					walk_right_reg <= 0;
					aaah_reg <= 1;
					digging_reg <= 0;
					
				DIG:
					walk_left_reg <= 0;
					walk_right_reg <= 0;
					aaah_reg <= 0;
					digging_reg <= 1;
			endcase
		end
	end
	
	// Assign outputs to output ports
	assign walk_left = walk_left_reg;
	assign walk_right = walk_right_reg;
	assign aaah = aaah_reg;
	assign digging = digging_reg;
endmodule
