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

	// Define state enum
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} states;
	
	// Define current state register and next state wire
	reg states current_state, next_state;
	
	// Define output registers
	reg walk_left_reg, walk_right_reg, aaah_reg;
	
	// Sequential logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset state and output registers
			current_state <= WALK_LEFT;
			walk_left_reg <= 1'b1; // Start by walking left
			walk_right_reg <= 1'b0;
			aaah_reg <= 1'b0;
		end else begin
			// Update current state
			current_state <= next_state;
			
			// Update output registers based on current state
			case (current_state)
				WALK_LEFT: begin
					walk_left_reg <= 1'b1;
					walk_right_reg <= 1'b0;
					aaah_reg <= 1'b0;
				end
				WALK_RIGHT: begin
					walk_left_reg <= 1'b0;
					walk_right_reg <= 1'b1;
					aaah_reg <= 1'b0;
				end
				FALL: begin
					// Fall state only changes outputs when ground reappears
					if (ground) begin
						if (walk_left_reg)
							walk_left_reg <= 1'b1;
						else
							walk_right_reg <= 1'b1;
					end
					aaah_reg <= 1'b1;
				end
				default: begin
					walk_left_reg <= 1'b1;
					walk_right_reg <= 1'b0;
					aaah_reg <= 1'b0;
				end
			endcase
		end
	end
	
	// Combinational logic
	always @* begin
		case (current_state)
			WALK_LEFT: begin
				if (bump_right || (bump_left && !bump_right))
					next_state = WALK_RIGHT;
				else if (ground == 0)
					next_state = FALL;
				else
					next_state = current_state;
			end
			WALK_RIGHT: begin
				if (bump_left || (bump_left && !bump_right))
					next_state = WALK_LEFT;
				else if (ground == 0)
					next_state = FALL;
				else
					next_state = current_state;
			end
			FALL: begin
				if (ground)
					next_state = current_state;
				else
					next_state = FALL;
			end
		endcase
	end
	
	// Assign outputs to output registers
	assign walk_left = walk_left_reg;
	assign walk_right = walk_right_reg;
	assign aaah = aaah_reg;

endmodule
