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

	// State Encoding
	typedef enum reg [2:0] {
		S_WALK_LEFT  = 3'b000,
		S_WALK_RIGHT = 3'b001,
		S_FALL_LEFT  = 3'b010,
		S_FALL_RIGHT = 3'b011,
		S_DIG_LEFT   = 3'b100,
		S_DIG_RIGHT  = 3'b101,
		S_SPLAT      = 3'b110
	} state_t;
	
	state_t state, next_state;
	reg [4:0] fall_counter;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S_WALK_LEFT;
			fall_counter <= 0;
		end else begin
			state <= next_state;
			if (state == S_FALL_LEFT || state == S_FALL_RIGHT)
				fall_counter <= fall_counter + 1;
			else
				fall_counter <= 0;
		end
	end
	
	always @(*) begin
		// Default outputs
		walk_left  = 0;
		walk_right = 0;
		aaah       = 0;
		digging    = 0;
		
		case (state)
			S_WALK_LEFT: begin
				if (!ground)
					next_state = S_FALL_LEFT;
				else if (dig)
					next_state = S_DIG_LEFT;
				else if (bump_left)
					next_state = S_WALK_RIGHT;
				else
					next_state = S_WALK_LEFT;
				
				walk_left = 1;
			end
			S_WALK_RIGHT: begin
				if (!ground)
					next_state = S_FALL_RIGHT;
				else if (dig)
					next_state = S_DIG_RIGHT;
				else if (bump_right)
					next_state = S_WALK_LEFT;
				else
					next_state = S_WALK_RIGHT;
				
				walk_right = 1;
			end
			S_FALL_LEFT, S_FALL_RIGHT: begin
				if (ground) begin
					if (fall_counter >= 20)
						next_state = S_SPLAT;
					else if (state == S_FALL_LEFT)
						next_state = S_WALK_LEFT;
					else
						next_state = S_WALK_RIGHT;
				end else
					next_state = state;
				
				aaah = 1;
			end
			S_DIG_LEFT: begin
				if (!ground)
					next_state = S_FALL_LEFT;
				else
					next_state = S_DIG_LEFT;
				
				digging = 1;
			end
			S_DIG_RIGHT: begin
				if (!ground)
					next_state = S_FALL_RIGHT;
				else
					next_state = S_DIG_RIGHT;
				
				digging = 1;
			end
			S_SPLAT: begin
				next_state = S_SPLAT;
			end
			default: begin
				next_state = S_WALK_LEFT;
			end
		endcase
	end

endmodule
