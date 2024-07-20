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

	reg [2:0] state, next_state;
	
	// States encoding
	localparam WALK_LEFT = 3'b000,
	           WALK_RIGHT = 3'b001,
	           FALL_LEFT = 3'b010,
	           FALL_RIGHT = 3'b011,
	           DIG_LEFT = 3'b100,
	           DIG_RIGHT = 3'b101;
	
	// State transition
	always @(*) begin
		case (state)
			WALK_LEFT: begin
				if (ground == 0)
					next_state = FALL_LEFT;
				else if (dig == 1)
					next_state = DIG_LEFT;
				else if (bump_left)
					next_state = WALK_RIGHT;
				else
					next_state = WALK_LEFT;
			end
			WALK_RIGHT: begin
				if (ground == 0)
					next_state = FALL_RIGHT;
				else if (dig == 1)
					next_state = DIG_RIGHT;
				else if (bump_right)
					next_state = WALK_LEFT;
				else
					next_state = WALK_RIGHT;
			end
			FALL_LEFT: begin
				if (ground == 1)
					next_state = WALK_LEFT;
				else
					next_state = FALL_LEFT;
			end
			FALL_RIGHT: begin
				if (ground == 1)
					next_state = WALK_RIGHT;
				else
					next_state = FALL_RIGHT;
			end
			DIG_LEFT: begin
				if (ground == 0)
					next_state = FALL_LEFT;
				else
					next_state = DIG_LEFT;
			end
			DIG_RIGHT: begin
				if (ground == 0)
					next_state = FALL_RIGHT;
				else
					next_state = DIG_RIGHT;
			end
			default: next_state = WALK_LEFT;
		endcase
	end
	
	// State update
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WALK_LEFT;
		else
			state <= next_state;
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
			FALL_LEFT, FALL_RIGHT: aaah = 1;
			DIG_LEFT: digging = 1;
			DIG_RIGHT: digging = 1;
		endcase
	end

endmodule
