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
		START, WALK, FALL, DIG, SPLATTER
	} state_t;
	
	// Define state register and next state
	reg [1:0] state_reg, state_next;
	
	// Define output registers
	reg walk_left_reg, walk_right_reg, aaah_reg, digging_reg;
	
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset the state machine
			state_reg <= START;
			walk_left_reg <= 1;
			walk_right_reg <= 0;
			aaah_reg <= 0;
			digging_reg <= 0;
		end else begin
			// Update the state machine
			state_reg <= state_next;
			walk_left_reg <= walk_left_reg;
			walk_right_reg <= walk_right_reg;
			aaah_reg <= aaah_reg;
			digging_reg <= digging_reg;
		end
	end
	
	always_comb begin
		// Initialize next state
		state_next = state_reg;
		
		case (state_reg)
			START: begin
				if (areset) begin
					state_next = WALK;
					walk_left_reg = 1;
					walk_right_reg = 0;
				end
			end
			
			WALK: begin
				if (bump_left && !bump_right) begin
					state_next = WALK;
					walk_left_reg = 0;
					walk_right_reg = 1;
				end else if (!bump_left && bump_right) begin
					state_next = WALK;
					walk_left_reg = 1;
					walk_right_reg = 0;
				end else if (bump_left && bump_right) begin
					state_next = WALK;
					walk_left_reg = 1;
					walk_right_reg = 0;
				end else if (!ground) begin
					state_next = FALL;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
				end else if (dig && ground) begin
					state_next = DIG;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
				end
			end
			
			FALL: begin
				if (ground) begin
					state_next = WALK;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
				end else if (!ground && dig) begin
					state_next = DIG;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
				end else if (!ground && !dig) begin
					state_next = FALL;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
				end
			end
			
			DIG: begin
				if (!ground) begin
					state_next = FALL;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
				end else if (ground && !dig) begin
					state_next = WALK;
					walk_left_reg = walk_left_reg;
					walk_right_reg = walk_right_reg;
				end
			end
			
			SPLATTER: begin
				// Stay in SPLATTER state forever
			end
		endcase
	end
	
	always_comb begin
		// Assign output values based on the current state
		case (state_reg)
			START: begin
				walk_left = walk_left_reg;
				walk_right = walk_right_reg;
				aaah = aaah_reg;
				digging = digging_reg;
			end
			
			WALK: begin
				walk_left = walk_left_reg;
				walk_right = walk_right_reg;
				aaah = aaah_reg;
				digging = digging_reg;
			end
			
			FALL: begin
				walk_left = walk_left_reg;
				walk_right = walk_right_reg;
				aaah = 1;
				digging = digging_reg;
			end
			
			DIG: begin
				walk_left = walk_left_reg;
				walk_right = walk_right_reg;
				aaah = aaah_reg;
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
