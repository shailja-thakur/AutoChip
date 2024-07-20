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

	typedef enum logic [3:0] {
		WALK_LEFT = 4'b0001, 
		WALK_RIGHT = 4'b0010, 
		FALLING = 4'b0100, 
		DIGGING = 4'b1000, 
		SPLATTER = 4'b0000
	} state_t;
	
	state_t state, next_state;
	logic [4:0] fall_count; // 5-bit counter for fall time

	// Next state logic
	always @(*) begin
		case (state)
			WALK_LEFT: begin
				if (!ground)
					next_state = FALLING;
				else if (dig)
					next_state = DIGGING;
				else if (bump_left)
					next_state = WALK_RIGHT;
				else
					next_state = WALK_LEFT; 
			end
			WALK_RIGHT: begin
				if (!ground)
					next_state = FALLING;
				else if (dig)
					next_state = DIGGING;
				else if (bump_right)
					next_state = WALK_LEFT;
				else
					next_state = WALK_RIGHT;
			end
			FALLING: begin
				if (ground) begin
					if (fall_count > 20)
						next_state = SPLATTER;
					else if (state == WALK_LEFT)
						next_state = WALK_LEFT;
					else
						next_state = WALK_RIGHT;
				end else
					next_state = FALLING;
			end
			DIGGING: begin
				if (!ground)
					next_state = FALLING;
				else
					next_state = DIGGING;
			end
			SPLATTER: begin
				next_state = SPLATTER; // Remain in SPLATTER state
			end
			default: next_state = WALK_LEFT;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			fall_count <= 0;
		end else begin
			state <= next_state;
			if (state == FALLING && !ground)
				fall_count <= fall_count + 1;
			else if (ground)
				fall_count <= 0;
		end
	end

	// Output logic
	always @(*) begin
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;
		case (state)
			WALK_LEFT: walk_left = 1;
			WALK_RIGHT: walk_right = 1;
			FALLING: aaah = 1;
			DIGGING: digging = 1;
			SPLATTER: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

endmodule
