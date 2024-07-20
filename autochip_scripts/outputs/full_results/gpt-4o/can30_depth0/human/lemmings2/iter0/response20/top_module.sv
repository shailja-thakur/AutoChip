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
	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;
	parameter FALL_LEFT = 2'b10;
	parameter FALL_RIGHT = 2'b11;
	
	// State variables
	reg [1:0] current_state, next_state;

	// State transition
	always @(*) begin
		case (current_state)
			WALK_LEFT: begin
				if (!ground)                next_state = FALL_LEFT;
				else if (bump_left)         next_state = WALK_RIGHT;
				else                        next_state = WALK_LEFT;
			end
			WALK_RIGHT: begin
				if (!ground)                next_state = FALL_RIGHT;
				else if (bump_right)        next_state = WALK_LEFT;
				else                        next_state = WALK_RIGHT;
			end
			FALL_LEFT: begin
				if (ground)                 next_state = WALK_LEFT;
				else                        next_state = FALL_LEFT;
			end
			FALL_RIGHT: begin
				if (ground)                 next_state = WALK_RIGHT;
				else                        next_state = FALL_RIGHT;
			end
			default:                        next_state = WALK_LEFT;  // safety default to avoid undefined behaviour
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= WALK_LEFT;
		else
			current_state <= next_state;
		end
	end

	// Output logic for Moore machine
	always @(*) begin
		case (current_state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
			end
			FALL_LEFT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
			end
			FALL_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
			end
			default: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
			end
		endcase
	end

endmodule
