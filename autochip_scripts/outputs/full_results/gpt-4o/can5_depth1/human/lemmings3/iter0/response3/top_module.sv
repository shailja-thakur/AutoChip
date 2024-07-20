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
	
	// State encoding
	typedef enum reg [2:0] {
		LEFT = 3'b000,
		RIGHT = 3'b001,
		FALL_LEFT = 3'b010,
		FALL_RIGHT = 3'b011,
		DIG_LEFT = 3'b100,
		DIG_RIGHT = 3'b101
	} state_t;
	
	state_t current_state, next_state;

	// State transitions
	always @(*) begin
		case (current_state)
			LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else if (dig)
					next_state = DIG_LEFT;
				else if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else if (dig)
					next_state = DIG_RIGHT;
				else if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			FALL_LEFT: begin
				if (ground)
					next_state = LEFT;
				else
					next_state = FALL_LEFT;
			end
			FALL_RIGHT: begin
				if (ground)
					next_state = RIGHT;
				else
					next_state = FALL_RIGHT;
			end
			DIG_LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else
					next_state = DIG_LEFT;
			end
			DIG_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else
					next_state = DIG_RIGHT;
			end
			default:
				next_state = LEFT;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= LEFT;
		else
			current_state <= next_state;
	end

	// Output logic
	assign walk_left = (current_state == LEFT);
	assign walk_right = (current_state == RIGHT);
	assign aaah = (current_state == FALL_LEFT) || (current_state == FALL_RIGHT);
	assign digging = (current_state == DIG_LEFT) || (current_state == DIG_RIGHT);
	
endmodule
