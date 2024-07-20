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

	// State definition
	typedef enum reg [2:0] {
		LEFT,
		RIGHT,
		FALLING_LEFT,
		FALLING_RIGHT,
		DIGGING_LEFT,
		DIGGING_RIGHT,
		SPLATTER
	} state_t;
	
	state_t state, next_state;
	reg [4:0] fall_counter; // 5-bit counter for maximum fall time of 20 cycles
	
	// State transition logic
	always @* begin
		case (state)
			LEFT: begin
				if (!ground) 
					next_state = FALLING_LEFT;
				else if (dig) 
					next_state = DIGGING_LEFT;
				else if (bump_left) 
					next_state = RIGHT;
				else 
					next_state = LEFT;
			end
			
			RIGHT: begin
				if (!ground) 
					next_state = FALLING_RIGHT;
				else if (dig) 
					next_state = DIGGING_RIGHT;
				else if (bump_right) 
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			
			FALLING_LEFT: begin
				if (ground) 
					next_state = (fall_counter > 20) ? SPLATTER : LEFT;
				else 
					next_state = FALLING_LEFT;
			end
			
			FALLING_RIGHT: begin
				if (ground) 
					next_state = (fall_counter > 20) ? SPLATTER : RIGHT;
				else 
					next_state = FALLING_RIGHT;
			end
			
			DIGGING_LEFT: begin
				if (!ground) 
					next_state = FALLING_LEFT;
				else 
					next_state = DIGGING_LEFT;
			end
			
			DIGGING_RIGHT: begin
				if (!ground) 
					next_state = FALLING_RIGHT;
				else 
					next_state = DIGGING_RIGHT;
			end
			
			SPLATTER: next_state = SPLATTER; // Remain in splatter state
			
			default: next_state = LEFT;
		endcase
	end
	
	// State flip-flops
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT;
			fall_counter <= 0;
		end
		else begin
			state <= next_state;
			if (state == FALLING_LEFT || state == FALLING_RIGHT)
				fall_counter <= fall_counter + 1;
			else
				fall_counter <= 0;
		end
	end
	
	// Output logic
	always @* begin
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;
		case (state)
			LEFT: walk_left = 1;
			RIGHT: walk_right = 1;
			FALLING_LEFT, FALLING_RIGHT: aaah = 1;
			DIGGING_LEFT: digging = 1;
			DIGGING_RIGHT: digging = 1;
			SPLATTER: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end
	
endmodule
