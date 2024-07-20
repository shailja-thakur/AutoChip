module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

	// Define states
	typedef enum logic [1:0] {
		STATE_WALK_LEFT,
		STATE_WALK_RIGHT,
		STATE_FALL
	} states_t;
	
	// Declare state register and initialize to STATE_WALK_LEFT
	reg [1:0] state_reg;
	initial begin
		state_reg = STATE_WALK_LEFT;
	end
	
	// Declare next state logic
	reg [1:0] next_state;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			next_state = STATE_WALK_LEFT;
		end else begin
			case (state_reg)
				STATE_WALK_LEFT:
					if (bump_right) begin
						next_state = STATE_WALK_RIGHT;
					end else if (ground) begin
						next_state = STATE_WALK_LEFT;
					end else begin
						next_state = STATE_FALL;
					end
				
				STATE_WALK_RIGHT:
					if (bump_left) begin
						next_state = STATE_WALK_LEFT;
					end else if (ground) begin
						next_state = STATE_WALK_RIGHT;
					end else begin
						next_state = STATE_FALL;
					end
				
				STATE_FALL:
					if (ground) begin
						if (state_reg == STATE_WALK_LEFT) begin
							next_state = STATE_WALK_LEFT;
						end else begin
							next_state = STATE_WALK_RIGHT;
						end
					end else begin
						next_state = STATE_FALL;
					end
			endcase
		end
	end
	
	// Update state register with next_state on positive edge of clk
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= STATE_WALK_LEFT;
		end else begin
			state_reg <= next_state;
		end
	end
	
	// Output logic
	always @(state_reg, bump_left, bump_right, ground) begin
		case (state_reg)
			STATE_WALK_LEFT:
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			
			STATE_WALK_RIGHT:
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			
			STATE_FALL:
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
		endcase
	end

endmodule
