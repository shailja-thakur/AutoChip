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

	// State encoding
	parameter WALK_LEFT  = 3'b000;
	parameter WALK_RIGHT = 3'b001;
	parameter FALL_LEFT  = 3'b010;
	parameter FALL_RIGHT = 3'b011;
	parameter DIG_LEFT   = 3'b100;
	parameter DIG_RIGHT  = 3'b101;

	reg [2:0] state, next_state;

	// State transition logic
	always @(*) begin
		case(state)
			WALK_LEFT: begin
				if (!ground) next_state = FALL_LEFT;
				else if (dig) next_state = DIG_LEFT;
				else if (bump_left) next_state = WALK_RIGHT;
				else next_state = WALK_LEFT;
			end
			WALK_RIGHT: begin
				if (!ground) next_state = FALL_RIGHT;
				else if (dig) next_state = DIG_RIGHT;
				else if (bump_right) next_state = WALK_LEFT;
				else next_state = WALK_RIGHT;
			end
			FALL_LEFT: begin
				if (ground) next_state = WALK_LEFT;
				else next_state = FALL_LEFT;
			end
			FALL_RIGHT: begin
				if (ground) next_state = WALK_RIGHT;
				else next_state = FALL_RIGHT;
			end
			DIG_LEFT: begin
				if (!ground) next_state = FALL_LEFT;
				else next_state = DIG_LEFT;
			end
			DIG_RIGHT: begin
				if (!ground) next_state = FALL_RIGHT;
				else next_state = DIG_RIGHT;
			end
			default: next_state = WALK_LEFT; // Default to safe state
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case(state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			end
			FALL_LEFT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			FALL_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			end
			DIG_LEFT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			DIG_RIGHT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			end
			default: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

endmodule
