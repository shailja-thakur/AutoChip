module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	// State encoding
	typedef enum logic [1:0] {
		LEFT  = 2'b01,
		RIGHT = 2'b10
	} state_t;
	
	state_t state, next_state;

	// Output logic
	always @(*) begin
		case (state)
			LEFT: begin
				walk_left = 1;
				walk_right = 0;
			end
			RIGHT: begin
				walk_left = 0;
				walk_right = 1;
			end
			default: begin
				walk_left = 0;
				walk_right = 0;
			end
		endcase
	end

	// State transition logic
	always @(*) begin
		case (state)
			LEFT: begin
				if (bump_left)
					next_state = RIGHT;
				else
					next_state = LEFT;
			end
			RIGHT: begin
				if (bump_right)
					next_state = LEFT;
				else
					next_state = RIGHT;
			end
			default: begin
				next_state = LEFT; // default reset state
			end
		endcase
	end

	// State register
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= LEFT;
		else
			state <= next_state;
	end

endmodule
