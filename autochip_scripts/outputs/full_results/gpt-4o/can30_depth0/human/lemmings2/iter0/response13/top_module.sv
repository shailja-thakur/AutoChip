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

	// Declaration of states
	typedef enum logic [2:0] {
		LEFT_WALKING = 3'b000,
		RIGHT_WALKING = 3'b001,
		LEFT_FALLING = 3'b010,
		RIGHT_FALLING = 3'b011,
		FALLING = 3'b100
	} state_t;
	
	state_t state, next_state;
	
	// State transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= LEFT_WALKING;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always_comb begin
		case (state)
			LEFT_WALKING: begin
				if (~ground) next_state = LEFT_FALLING;
				else if (bump_left || bump_right) next_state = RIGHT_WALKING;
				else next_state = LEFT_WALKING;
			end
			RIGHT_WALKING: begin
				if (~ground) next_state = RIGHT_FALLING;
				else if (bump_left || bump_right) next_state = LEFT_WALKING;
				else next_state = RIGHT_WALKING;
			end
			LEFT_FALLING: begin
				if (ground) next_state = LEFT_WALKING;
				else next_state = LEFT_FALLING;
			end
			RIGHT_FALLING: begin
				if (ground) next_state = RIGHT_WALKING;
				else next_state = RIGHT_FALLING;
			end
			default: next_state = LEFT_WALKING;
		endcase
	end
	
	// Output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
		end else begin
			case (state)
				LEFT_WALKING: begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end
				RIGHT_WALKING: begin
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
				end
				LEFT_FALLING,
				RIGHT_FALLING: begin
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
				end
				default: begin
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
				end
			endcase
		end
	end
endmodule
