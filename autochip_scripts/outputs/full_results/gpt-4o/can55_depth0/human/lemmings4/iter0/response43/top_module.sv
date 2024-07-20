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

	// States
	typedef enum reg [3:0] {
		STATE_WALK_LEFT  = 4'd0,
		STATE_WALK_RIGHT = 4'd1,
		STATE_FALL_LEFT  = 4'd2,
		STATE_FALL_RIGHT = 4'd3,
		STATE_DIG_LEFT   = 4'd4,
		STATE_DIG_RIGHT  = 4'd5,
		STATE_SPLAT      = 4'd6
	} state_t;
	
	state_t state, next_state;
	reg [4:0] fall_count;

	// Combinational logic: State transition logic
	always @(*) begin
		case (state)
			STATE_WALK_LEFT: begin
				if (!ground) next_state = STATE_FALL_LEFT;
				else if (dig) next_state = STATE_DIG_LEFT;
				else if (bump_left) next_state = STATE_WALK_RIGHT;
				else next_state = STATE_WALK_LEFT;
			end
			STATE_WALK_RIGHT: begin
				if (!ground) next_state = STATE_FALL_RIGHT;
				else if (dig) next_state = STATE_DIG_RIGHT;
				else if (bump_right) next_state = STATE_WALK_LEFT;
				else next_state = STATE_WALK_RIGHT;
			end
			STATE_FALL_LEFT, STATE_FALL_RIGHT: begin
				if (ground) begin
					if (fall_count > 20) next_state = STATE_SPLAT;
					else next_state = (state == STATE_FALL_LEFT) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
				end else begin
					next_state = state;
				end
			end
			STATE_DIG_LEFT: begin
				if (!ground) next_state = STATE_FALL_LEFT;
				else next_state = STATE_DIG_LEFT;
			end
			STATE_DIG_RIGHT: begin
				if (!ground) next_state = STATE_FALL_RIGHT;
				else next_state = STATE_DIG_RIGHT;
			end
			STATE_SPLAT: begin
				next_state = STATE_SPLAT;
			end
			default: begin 
				next_state = STATE_WALK_LEFT; // Default state in case of an error
			end
		endcase
	end

	// Sequential logic: State flip-flops
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_WALK_LEFT;
			fall_count <= 0;
		end else begin
			// Fall count logic
			if (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT) begin
				fall_count <= fall_count + 1;
			end else if (ground) begin
				fall_count <= 0;
			end

			state <= next_state;
		end
	end
	
	// Outputs
	always @(*) begin
		// Default output values
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;
		
		case (state)
			STATE_WALK_LEFT: begin
				walk_left = 1;
			end
			STATE_WALK_RIGHT: begin
				walk_right = 1;
			end
			STATE_FALL_LEFT, STATE_FALL_RIGHT: begin
				aaah = 1;
			end
			STATE_DIG_LEFT: begin
				digging = 1;
			end
			STATE_DIG_RIGHT: begin
				digging = 1;
			end
			STATE_SPLAT: begin
				// All outputs remain 0
			end
		endcase
	end
endmodule
