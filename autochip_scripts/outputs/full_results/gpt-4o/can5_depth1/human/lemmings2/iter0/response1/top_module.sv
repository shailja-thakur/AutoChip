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
	// State encoding
	typedef enum logic [1:0] {
		LEFT = 2'b00,
		RIGHT = 2'b01,
		FALL_LEFT = 2'b10,
		FALL_RIGHT = 2'b11
	} state_t;
	
	state_t state, next_state;

	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= LEFT; 
		else
			state <= next_state;
	end

	always_comb begin
		next_state = state;
		case (state)
			LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else if (bump_left)
					next_state = RIGHT;
			end

			RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else if (bump_right)
					next_state = LEFT;
			end

			FALL_LEFT: begin
				if (ground)
					next_state = LEFT;
			end

			FALL_RIGHT: begin
				if (ground)
					next_state = RIGHT;
			end
		endcase
	end

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
		end
		else begin
			case (next_state)
				LEFT: begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end

				RIGHT: begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end

				FALL_LEFT: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end

				FALL_RIGHT: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end
			endcase
		end
	end
endmodule
